$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://api.qrcode-monkey.com//qr/custom',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
  //sửa dòng này thôi nha
  CURLOPT_POSTFIELDS =>'{"data":"https://www.leminhtriet.com",
  "config":{
  "body":"dot","eye":"frame13",
  "eyeBall":"ball15","erf1":[],"erf2":[],"erf3":[],"brf1":[],"brf2":[],"brf3":[],"bodyColor":"#9C1C1C","bgColor":"#FFFFFF","eye1Color":"#9C1C1C","eye2Color":"#9C1C1C","eye3Color":"#9C1C1C","eyeBall1Color":"#9C1C1C","eyeBall2Color":"#9C1C1C","eyeBall3Color":"#9C1C1C","gradientColor1":"","gradientColor2":"","gradientType":"linear","gradientOnEyes":"true","logo":"#youtube-circle","logoMode":"default"},"size":1000,"download":"imageUrl","file":"svg"
  }',
  
  CURLOPT_HTTPHEADER => array(
    'accept: */*',
    'accept-language: vi-VN,vi;q=0.9,en-US;q=0.8,en;q=0.7,fr-FR;q=0.6,fr;q=0.5',
    'cache-control: no-cache',
    'content-type: text/plain;charset=UTF-8',
    'dnt: 1',
    'origin: https://www.qrcode-monkey.com',
    'pragma: no-cache',
    'priority: u=1, i',
    'referer: https://www.qrcode-monkey.com/',
    'sec-ch-ua: "Chromium";v="128", "Not;A=Brand";v="24", "Google Chrome";v="128"',
    'sec-ch-ua-mobile: ?0',
    'sec-ch-ua-platform: "Windows"',
    'sec-fetch-dest: empty',
    'sec-fetch-mode: cors',
    'sec-fetch-site: same-site',
    'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36'
  ),
));

$response = curl_exec($curl);

curl_close($curl);

$json = $response;

// Giải mã JSON thành mảng PHP
$data = json_decode($json, true);

// Truy xuất giá trị của 'imageUrl'
$imageUrl = $data['imageUrl'];

// Thay thế các ký tự không hợp lệ (\/\/ -> //)
$imageUrl = "https:".str_replace('\/', '/', $imageUrl);

// Hiển thị đường dẫn