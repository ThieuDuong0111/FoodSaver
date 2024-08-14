#Docker

Step 1: build jar

Step 2: buid image

docker build --tag=foodsaveradmin:0.0.1 .

Step 3: run container

docker run -p 8081:8081 foodsaveradmin:0.0.1

(port trước là port container, port sau là port của host)