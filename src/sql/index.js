
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

export function selectMessage(db,topic,callback) {
  var str = []
  db.all(`SELECT * from message where ytopic = ${topic};`,(err,res) => {
    str = res
    callback && callback(res)
  })
}

export function SELSQL(db,topic,data){
  db.all(`  UPDATE userMessage set message = '${data}' WHERE topic = ${topic} `
    
  )
}