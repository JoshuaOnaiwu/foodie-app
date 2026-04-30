import http from 'k6/http';
import { sleep } from 'k6';

// Use pipeline value if available, otherwise fallback to your URL
const BASE_URL =
  __ENV.TARGET_URL || 'http://foodie-alb-36067267.us-east-1.elb.amazonaws.com';

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
  if (!BASE_URL) {
    throw new Error('TARGET_URL is not set');
  }

  // 🔥 heavy load (needed for frontend apps)
  for (let i = 0; i < 10; i++) {
    http.get(BASE_URL);
  }

  sleep(1);
}