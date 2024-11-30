resource "aws_route53_zone" "myZone" {
  name = "gal-rozman.com"
}

resource "aws_route53_record" "myRecord" {
  zone_id = aws_route53_zone.myZone.zone_id
  name    = "weather"
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.app_lb.dns_name]
}