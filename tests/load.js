import http from 'k6/http';
import { check, group } from 'k6';

export let options = {
  scenarios: {
    frontend_load: {
      executor: 'constant-arrival-rate',
      rate: 1000, // increase gradually later
      timeUnit: '1s',
      duration: '2m',
      preAllocatedVUs: 20,
      maxVUs: 100,
    },
  },
};

export default function () {
  const base = __ENV.TARGET_URL;

  group('load homepage', function () {
    let res1 = http.get(`${base}/`);
    check(res1, { 'home status 200': (r) => r.status === 200 });
  });

  group('load assets', function () {
    http.get(`${base}/styles.css`);
    http.get(`${base}/main.js`);
  });
}