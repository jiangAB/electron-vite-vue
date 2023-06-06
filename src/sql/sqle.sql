-- DROP TABLE IF EXISTS `usertable`;
CREATE TABLE usertable (
  `topic_id` InTeger PRIMARY KEY AUTOINCREMENT,
    name text,
    status InTeger DEFAULT 0
  ) 

CREATE TABLE message (
  `id` InTeger PRIMARY KEY AUTOINCREMENT,
    fromid InTeger,  --发送人ID
    toid InTeger ,    --接收人ID
    context text,       --消息内容
    logtime TIMESTAMP default (datetime('now', 'localtime'))  ,      --时间
    FOREIGN KEY (fromid) REFERENCES usertable(topic_id) on delete cascade on update cascade on insert cascade,
    FOREIGN KEY (toid) REFERENCES usertable(topic_id) on delete cascade on update cascade on insert cascade
  
  ) 

CREATE TABLE topicGroup (
  `id` InTeger PRIMARY KEY AUTOINCREMENT,
    me_id InTeger,
    other_id InTeger,
    FOREIGN KEY (me_id) REFERENCES usertable(topic_id) on delete cascade on update cascade on insert cascade
    FOREIGN KEY (other_id) REFERENCES usertable(topic_id) on delete cascade on update cascade on insert cascade
  ) 
DROP TABLE topicGroup
INSERT INTO message (fromid,toid,context) VALUES (1,2,'你好吗');
INSERT INTO message (fromid,toid,context) VALUES (2,1,'我很好啊');

INSERT INTO message (fromid,toid,context) VALUES (1,3,'你好吗,小绿');
INSERT INTO message (fromid,toid,context) VALUES (3,1,'我很好啊,小红');

INSERT INTO topicGroup (me_id,other_id)  VALUES (1,2);
INSERT INTO topicGroup (me_id,other_id)  VALUES (1,3);
INSERT INTO usertable (name) VALUES ('小绿');
-- INSERT INTO usertable  VALUES (4,'小紫', '147');
-- INSERT INTO usertable (name , topic) VALUES ('小黄' , '258');
SELECT * from message LIMIT 10,10
SELECT * from usertable;
SELECT * from topicGroup;
PRAGMA foreign_keys = NO;
INSERT INTO message (fromid,toid,context) VALUES (1,2,'啊实打实的')
PRAGMA foreign_key_list(message);
INSERT INTO message (fromid,toid,context) VALUES (1,2,'小蓝的测试')
SELECT * from topicGroup INNER JOIN usertable ON other_id = topic_id
SELECT * from message WHERE fromid = 1 AND toid = 3 OR fromid = 3 AND toid = 1
SELECT * from message WHERE fromid = '1' AND toid = '2' OR fromid = '2' AND toid = '1'

SELECT * from (SELECT * from message WHERE fromid = '1' AND toid = '2' OR fromid = '2' AND toid = '1' ORDER by id DESC limit 0,10) ORDER by id 
DELETE from message  where 1