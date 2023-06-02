-- DROP TABLE IF EXISTS `usertable`;
CREATE TABLE usertable (
  `topic_id` InTeger PRIMARY KEY AUTOINCREMENT,
    name text
  ) 

CREATE TABLE message (
  `id` InTeger PRIMARY KEY AUTOINCREMENT,
    ytopic InTeger,
    data text,
    FOREIGN KEY (ytopic) REFERENCES usertable(topic_id) on delete cascade on update cascade on insert cascade
  ) 

CREATE TABLE topicGroup (
  `id` InTeger PRIMARY KEY AUTOINCREMENT,
    metopic InTeger,
    youtopic InTeger,
    FOREIGN KEY (youtopic) REFERENCES usertable(topic_id) on delete cascade on update cascade on insert cascade
    FOREIGN KEY (metopic) REFERENCES usertable(topic_id) on delete cascade on update cascade on insert cascade
  ) 
DROP TABLE topicGroup
INSERT INTO usertable (name) VALUES ('小s423er');
INSERT INTO topicGroup (metopic,youtopic)  VALUES (1, 2);
INSERT INTO usertable  VALUES (3,'小绿', '789');
-- INSERT INTO usertable  VALUES (4,'小紫', '147');
-- INSERT INTO usertable (name , topic) VALUES ('小黄' , '258');
SELECT * from message;
SELECT * from usertable;
SELECT * from topicGroup;
PRAGMA foreign_keys = NO;
PRAGMA foreign_key_list(message);