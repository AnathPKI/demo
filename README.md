Anath Demo
===

Docker compose files providing a demo environment of
(Anath)[https://github.com/AnathPKI].


Requirements
---

* Docker Engine 17.04.0+
* Docker Compose 1.12.0+


Standard mode
---

In standard mode, the Anath server immediately signs CSR, without
requiring a confirmation token.

Use the following command to start Anath in standard mode

    docker-compose up


"Sign after confirmation" mode
---

In "sign after confirmation" mode, the Anath server sends a
confirmation token to the user using SMTP. The user is expected to
confirm the CSR using this token.

Use the following command to start Anath in "sign after confirmation"
mode

    docker-compose \
	 -f docker-compose.yml \
	 -f docker-compose-confirming-override.yml \
	 up


Test Image
---

The latest development release is available as test image. To start
Anath in standard mode using the test image, use the following command

    docker-compose \
	 -f docker-compose.yml \
	 -f docker-compose-test-override.yml \
	 up
	 
To start Anath in "sign after confirmation" mode using the test image,
use the following command

    docker-compose \
	 -f docker-compose.yml \
	 -f docker-compose-confirming-override.yml \
	 -f docker-compose-test-override.yml \
	 up
