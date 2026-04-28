import http from 'k6/http';
import { check, sleep } from 'k6';

export let options = {
  stages: [
    { duration: '30s', target: 50 },   // warm-up
    { duration: '1m', target: 100 },   // moderate load
    { duration: '1m', target: 200 },   // peak load
    { duration: '30s', target: 0 },    // cool down
  ],
};

export default function () {
  const url = __ENV.TARGET_URL;

  const res = http.get(url);

  check(res, {
    'status is 200': (r) => r.status === 200,
    'response time < 1000ms': (r) => r.timings.duration < 1000,
  });

  sleep(1);
}