import http from 'k6/http';
import { check } from 'k6';

export let options = {
  stages: [
    { duration: '30s', target: 5 },   // warm-up
    { duration: '1m', target: 10 },   // ramp to max
    { duration: '1m', target: 10 },   // sustain load
    { duration: '30s', target: 0 },   // cool down
  ],
};

export default function () {
  const url = __ENV.TARGET_URL;

  const res = http.get(url);

  check(res, {
    'status is 200': (r) => r.status === 200,
    'response time < 1000ms': (r) => r.timings.duration < 1000,
  });

  // sleep removed intentionally
}