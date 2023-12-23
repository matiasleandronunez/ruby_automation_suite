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
        { duration: '1m', target: 150 }, // Ramp-up to 150 concurrent users in 1 minute
        { duration: '8h', target: 150 }, // Keep stable for 8 hours
        { duration: '1m', target: 0 },  // Ramp-down to 0 concurrent users in 1 minute
    ],
    thresholds: {
        http_req_duration: ['p(95)<500'], // 95% of requests should be below 500ms
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
