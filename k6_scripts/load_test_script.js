import http from 'k6/http';
import { check, sleep } from 'k6';

// Mix of front and API urls for users to GET
const targetUrls = [
    `${__ENV.base_uri}/index.html`,
    `${__ENV.base_api_uri}/product/`,
    `${__ENV.base_uri}/index.html#/checkout`,
    `${__ENV.base_api_uri}/order/`,
];

export let options = {
    stages: [
        { duration: '10s', target: 10 }, // Ramp-up to 10 concurrent users in 10 seconds
        { duration: '1m', target: 10 }, // Stay at 10 concurrent users for 1 minute
        { duration: '10s', target: 0 },  // Ramp-down to 0 concurrent users in 10 seconds
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
