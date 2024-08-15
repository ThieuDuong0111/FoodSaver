#Docker

Step 1: build jar

Step 2: add dockerfile

Step 3: buid image

docker build --tag=foodsaverapi:0.0.1 .

Step 4: run container

docker run -p 8080:8080 foodsaverAPI:0.0.1

(port trước là port container, port sau là port của host)