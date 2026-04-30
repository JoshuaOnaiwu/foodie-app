import http from 'k6/http';
import { sleep } from 'k6';

const BASE_URL = __ENV.TARGET_URL || 'http://foodie-alb-36067267.us-east-1.elb.amazonaws.com';

export const options = {
  stages: [
    { duration: '1m', target: 50 },    // warm up
    { duration: '2m', target: 150 },   // medium load
    { duration: '3m', target: 300 },   // heavy load
    { duration: '3m', target: 500 },   // force scaling
    { duration: '2m', target: 0 },     // cool down.
  ],
};

export default function () {
  if (!BASE_URL) {
    throw new Error('TARGET_URL is not set');
  }

  // 🔥 Multiply load per user (key for frontend apps)
  http.get(BASE_URL);
  http.get(BASE_URL);
  http.get(BASE_URL);
  http.get(BASE_URL);
  http.get(BASE_URL);

  sleep(1);
}