
const sqlite3 = require('sqlite3');

export function SQLiteInit() {
    let db = new sqlite3.Database('sqlite3.db',(err)=>{
        if (err) throw err;
        db.run(`PRAGMA foreign_keys = NO;`)
        console.log('数据库连接')
    })
    
    /* db.run(`
    create table userMessage 
    (
        name text not null,
        txt text not null,
        topic text not null,
        message text not null
    );
    
`) */
    return db
}
// 执行sql语句
export function INSQL(db,callback) {
  var str = []
  db.all('SELECT * from userTable;',(err,res) => {
    str = res
    callback && callback(res)
  })
}
//查询聊天列表
export function selectList(db,callback) {
  var str = []
  db.all('SELECT * from topicGroup INNER JOIN usertable ON other_id = topic_id',(err,res) => {
    str = res
    callback && callback(res)
  })
}
//查询聊天信息
export function selectMessage(db,fromid,toid,callback,i = 0) {
  var str = []
  console.log(`SELECT * from message WHERE fromid = '${fromid}' AND toid = '${toid}' OR fromid = '${toid}' AND toid = '${fromid}' limit ${i},10`)
  db.all(`SELECT * FROM (SELECT * from message WHERE fromid = '${fromid}' AND toid = '${toid}' OR fromid = '${toid}' AND toid = '${fromid}' ORDER by id DESC limit ${i},10) ORDER by id `,(err,res) => {
    str = res
    callback && callback(res)
  })
}

export function insertMessage(db,fromid,toid,context,callback) {
  console.log(fromid,toid,context)
  console.log(`INSERT INTO message (fromid,toid,context) VALUES (${fromid},${toid},'${context}')`)
  var str = []
  db.all(`INSERT INTO message (fromid,toid,context) VALUES (${fromid},${toid},'${context}') RETURNING id`,(err,res) => {
    db.all(`SELECT * from message WHERE id = ${res[0].id}`,(err,res) => {
      callback && callback(res)
    })
  })
}