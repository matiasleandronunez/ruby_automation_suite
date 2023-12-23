import http from 'k6/http';
import { check, sleep } from 'k6';

// Mix of front and API urls for users to GET
const targetUrls = [
    `${__ENV.BASE_URI}/index.html`,
    `${__ENV.BASE_API_URI}/product/`,
    `${__ENV.BASE_URI}/index.html#/checkout`,
    `${__ENV.BASE_API_URI}/order/`,
];

export let options = {
    stages: [
        { duration: '10s', target: 50 }, // Ramp-up to 50 concurrent users in 10 seconds
        { duration: '1m', target: 50 }, // stable
        { duration: '10s', target: 100 }, // Ramp-up to 100 concurrent users in 10 seconds
        { duration: '1m', target: 100 }, // stable
        { duration: '10s', target: 150 }, // Ramp-up to 150 concurrent users in 10 seconds
        { duration: '1m', target: 150 }, // stable
        { duration: '10s', target: 200 }, // Ramp-up to 200 concurrent users in 10 seconds
        { duration: '1m', target: 200 }, // stable
        { duration: '10s', target: 250 }, // Ramp-up to 250 concurrent users in 10 seconds
        { duration: '1m', target: 250 }, // stable
        { duration: '1m', target: 0 },  // Ramp-down to 0 concurrent users in 10 seconds
    ],
    thresholds: {
        http_req_duration: ['p(90)<1500'], // 90% of requests should be below 1500ms
    },
};

export default function () {
    // Select a random URL from the array
    const randomUrl = targetUrls[Math.floor(Math.random() * targetUrls.length)];

    let res = http.get(randomUrl);

    check(res, {
        'status is 200': (r) => r.status === 200,
    });

    sleep(1);
}
