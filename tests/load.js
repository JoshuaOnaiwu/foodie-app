import http from 'k6/http';
import { sleep } from 'k6';

export const options = {
  stages: [
    { duration: '1m', target: 50 },   // warm up
    { duration: '2m', target: 100 },  // medium load
    { duration: '3m', target: 200 },  // heavy load (trigger scaling)
    { duration: '2m', target: 300 },  // push harder (optional)
    { duration: '2m', target: 0 },    // cool down
  ],
};

export default function () {
  http.get('http://foodie-alb-36067267.us-east-1.elb.amazonaws.com');
  sleep(1);
}