CREATE DATABASE IF NOT EXISTS `sharetribe_development`;
CREATE DATABASE IF NOT EXISTS `sharetribe_test`;

GRANT ALL ON `sharetribe_development`.* TO 'sharetribe'@'%';
GRANT ALL ON `sharetribe_test`.* TO 'sharetribe'@'%';
