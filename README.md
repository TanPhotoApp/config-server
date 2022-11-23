# config-server

### Reference
Spring config server: https://docs.spring.io/spring-cloud-config/docs/current/reference/html/

Spring cloud bus: https://docs.spring.io/spring-cloud-bus/docs/current/reference/html/

### Setup RabbitMQ
In this project, we use RabbitMQ as message broker for cloud bus \
Guide download & install RabbitMQ: https://www.rabbitmq.com/download.html
```shell
# latest RabbitMQ 3.11
docker run -it --rm --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.11-management
```
RabbitMQ portal is on port 15672: http://localhost:15672 \
Login username / password: guest / guest

Spring cloud bus automatically configure the RabbitQM, the default config is:
```yaml
spring:
  rabbitmq:
    host: localhost
    username: guest
    password: guest
    port: 5672
```

### Refresh config
Send a POST refresh to busrefresh actuator endpoint:
```shell
curl --location --request POST 'http://localhost:8888/actuator/busrefresh' \
--header 'Cookie: JSESSIONID=AED2C36D0144D792E43AD35BA8968C71'
```

If config client uses ``@ConfigurationProperties``, we have to add ``@RefreshScope`` to load a new config whenever properties change
```java
@ConfigurationProperties(prefix = "token")
@RefreshScope
public record TokenProperties(long expireTime, String signingKey) {}
```