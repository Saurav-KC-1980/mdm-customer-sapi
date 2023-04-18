/*
 * Recreate objects for diagnostic logging
 */

DROP TABLE IF EXISTS logtable;
CREATE TABLE logtable (loggedAt DATETIME,log VARCHAR(5550));

DROP PROCEDURE IF EXISTS `log_msg`; 
DELIMITER //
CREATE PROCEDURE `log_msg`(msg VARCHAR(5550))
BEGIN
    insert into logtable (loggedAt,log) values(now(), msg);
END
//
