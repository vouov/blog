title=Java中AES加密兼容PHP等其他语言实现
date=2015-03-04
type=post
tags=java,加密,AES
status=published
~~~~~~

在之前的项目中涉及到java和php通信时采用AES加密，但是因为一些算法差异，导致不能直接通信，java需要做补位操作才能实现，后换了一种算法协议。今天在整理加密算法时，发现可以通过补位的方式来达到和PHP的通信，具体实现参照了 [AES加密CBC模式兼容互通四种编程语言平台](http://www.cnblogs.com/AloneSword/p/3485912.html).

两种语言的差别主要是对于内容的填充实现上不一致.

AES支持五中模式：CBC，CFB，ECB，OFB，PCBC；支持三种填充：NoPadding，PKCS5Padding，ISO10126Padding。不支持SSL3Padding。不支持“NONE”模式。
其中AES/ECB/NoPadding和我现在使用的AESUtil得出的结果相同(在16的整数倍情况下)。
不带模式和填充来获取AES算法的时候，其默认使用ECB/PKCS5Padding。

```
算法/模式/填充                16字节加密后数据长度        不满16字节加密后长度
AES/CBC/NoPadding             16                          不支持
AES/CBC/PKCS5Padding          32                          16
AES/CBC/ISO10126Padding       32                          16
AES/CFB/NoPadding             16                          原始数据长度
AES/CFB/PKCS5Padding          32                          16
AES/CFB/ISO10126Padding       32                          16
AES/ECB/NoPadding             16                          不支持
AES/ECB/PKCS5Padding          32                          16
AES/ECB/ISO10126Padding       32                          16
AES/OFB/NoPadding             16                          原始数据长度
AES/OFB/PKCS5Padding          32                          16
AES/OFB/ISO10126Padding       32                          16
AES/PCBC/NoPadding            16                          不支持
AES/PCBC/PKCS5Padding         32                          16
AES/PCBC/ISO10126Padding      32                          16
```

可以看到，在原始数据长度为16的整数倍时，假如原始数据长度等于16*n，则使用NoPadding时加密后数据长度等于16*n，其它情况下加密数据长度等于16*(n+1)。在不足16的整数倍的情况下，假如原始数据长度等于16*n+m[其中m小于16]，除了NoPadding填充之外的任何方式，加密数据长度都等于16*(n+1)；NoPadding填充情况下，CBC、ECB和PCBC三种模式是不支持的，CFB、OFB两种模式下则加密数据长度等于原始数据长度。

我的主要实现思路是对于密码和IV我们通过MD5算法强制让所得到的byte[]长度是16的倍数，对于要加密的内容，先获取长度，如果长度不是16的倍数，则申请大于现有长度而且是16倍数的byte[]内存，然后通过拷贝把原有的内容拷贝到新申请的内存空间，这就相当于做了补零操作。其实就是实现了java的AES/CBC/ZeroPadding算法;对于解密也一样需要对末端的补零位清理，达到加密和解密的值相等；具体实现代码下面给出参考实现。


java参考代码：

```java
/**
 * 兼容PHP等其他语言AES加密、解密方法
 *
 * @param mode
 * @param data
 * @param password
 * @param iv
 * @return
 * @throws Exception
 */
public static byte[] aesZeroPadding(int mode, byte[] data, String password, String iv) throws Exception {
	SecretKeySpec secretKeySpec = new SecretKeySpec(
		StringUtils.getBytesUtf8(md5(password).substring(0, 16)), 
		"AES");
	Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");

	IvParameterSpec ivParameterSpec = new IvParameterSpec(
		StringUtils.getBytesUtf8(md5(iv).substring(0, 16)));
	cipher.init(mode, secretKeySpec, ivParameterSpec);

	return cipher.doFinal(data);
}

/**
 * 兼容PHP等其他语言AES加密方法
 *
 * @param data
 * @param password
 * @param iv
 * @return
 * @throws Exception
 */
public static String encodeAESZeroPadding(String data, String password, String iv) {
	try {
		Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
		//对内容不是16整数倍数时补位
		int blockSize = cipher.getBlockSize();
		byte[] bytes = StringUtils.getBytesUtf8(data);
		int dataBytesLength = bytes.length;
		int mod = dataBytesLength % blockSize;
		if (mod != 0) {
			dataBytesLength = dataBytesLength + (blockSize - mod);
		}
		byte[] newBytes = new byte[dataBytesLength];
		System.arraycopy(bytes, 0, newBytes, 0, bytes.length);
		return Base64.encode(aesZeroPadding(Cipher.ENCRYPT_MODE, newBytes, password, iv));
	} catch (Exception e) {
		logger.error("AES ZeroPadding模式加密失败", e);
		throw new RuntimeException(e);
	}
}

/**
 * 兼容PHP等其他语言AES解密方法
 *
 * @param data
 * @param password
 * @param iv
 * @return
 * @throws Exception
 */
public static String decodeAESZeroPadding(String data, String password, String iv) {
	try {
		byte[] decodedBytes = aesZeroPadding(
			Cipher.DECRYPT_MODE, Base64.decode(data), password, iv);
		//去除增加的zero padding
		int emptyLength = 0;
		for (int i = decodedBytes.length; i > 0; i--) {

			if (decodedBytes[i - 1] == 0) {
				emptyLength++;
			} else {
				break;
			}
		}
		byte[] newBytes = new byte[decodedBytes.length - emptyLength];
		System.arraycopy(decodedBytes, 0, newBytes, 0, decodedBytes.length - emptyLength);
		return StringUtils.newStringUtf8(newBytes);
	} catch (Exception e) {
		logger.error("AES ZeroPadding模式解密失败", e);
		throw new RuntimeException(e);
	}
}
```

php参考代码：

```php
//加密
$encrypted = mcrypt_encrypt(MCRYPT_RIJNDAEL_128, $privateKey, $data, MCRYPT_MODE_CBC, $iv);
echo(base64_encode($encrypted));
echo '<br/>'; 

//解密
$encryptedData = base64_decode($encrypted);
$decrypted = mcrypt_decrypt(MCRYPT_RIJNDAEL_128, $privateKey, $encryptedData, MCRYPT_MODE_CBC, $iv);
echo($decrypted);
```
