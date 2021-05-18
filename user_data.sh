sudo su
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
systemctl start httpd
cat << EOF > /var/www/html/index.html
<html>
  <body bgcolor="black">
    <h2>
      <font color="gold">Build by Power of Terraform</font><font color="red"> v0.12</font>
    </h2>

    <br>

    <p>
      <font color="green">Server PrivateIP: </font><font color="aqua">$myip</font>
    </p>

    <br>
    <br>

    <font color="magenta">
      <strong>Version 1.0</strong>
    </font>
  <body>
</html>
EOF
systemctl restart httpd
systemctl enable httpd
