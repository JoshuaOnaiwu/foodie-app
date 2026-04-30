export const options = {
  stages: [
    { duration: '1m', target: 100 },
    { duration: '2m', target: 300 },
    { duration: '3m', target: 600 },
    { duration: '3m', target: 800 }, // push hard
    { duration: '2m', target: 0 },
  ],
};

export default function () {
  const url = __ENV.TARGET_URL;

  // 🔥 MUCH heavier load
  http.get(url);
  http.get(url);
  http.get(url);
  http.get(url);
  http.get(url);
  http.get(url);
  http.get(url);
  http.get(url);
  http.get(url);
  http.get(url);

  sleep(1);
}