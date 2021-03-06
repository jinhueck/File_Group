CREATE TABLE `tblMember2` (
  `id` char(20) NOT NULL,
  `pass` char(20) NOT NULL,
  `name` char(20) NOT NULL,
  `sex` char(1) NOT NULL,
  `birthday` char(6) NOT NULL,
  `email` char(30) NOT NULL,
  `zipcode` char(7) NOT NULL,
  `address` char(50) NOT NULL,
  `hobby` char(5) NOT NULL,
  `job` char(20) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `tblZipcode` (
  `zipcode` char(7) NOT NULL,
  `area1` char(10) DEFAULT NULL,
  `area2` char(20) DEFAULT NULL,
  `area3` char(40) DEFAULT NULL,
  `area4` char(20) DEFAULT NULL
)