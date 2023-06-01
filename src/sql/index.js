
const sqlite3 = require('sqlite3');

export function SQLiteInit() {
    let db = new sqlite3.Database('sqlite3.db',(err)=>{
        if (err) throw err;
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
  db.all('select * from userMessage',(err,res) => {
    str = res
    callback && callback(res)
  })
}
export function SELSQL(db,topic,data){
  db.all(`  UPDATE userMessage set message = '${data}' WHERE topic = ${topic} `
    
  )
}