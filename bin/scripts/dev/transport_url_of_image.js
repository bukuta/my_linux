/**
 * 接收参数
 *  待处理html文件
 *  处理规则      原路径规则  新路径规则
 *  输出文件位置
 */
var fs=require('fs');
var path=require('path');
var program=require('commander');
var through2=require('through2');

var stdout=process.stdout;
var stderr=process.stderr;
var CWD=process.cwd();
program.on('--help',function(){
    console.log('   Examples:');
    console.log();
    console.log('     $transport -o output/out.js -r /\.\.\/images\//\/abs\// src/aa.js');
    console.log('     $transport --output output/out.js --rules /\.\.\/images\//\/abs\// src/aa.js');
    console.log();
    });
program.version('0.0.1')
.option('-o, --output <output>','output path','output')
.option('-r --rules <rules>','rules','rules')

//console.log(program);

program.parse(process.argv);
//console.log(program);
//console.log(program.args);

if(!program.output||!program.rules&&!program.args.length){
  program.help();
}else{
  console.log(program.output);
  console.log(program.rules);
  console.log(process.cwd());
  doProcess(program.output,program.rules,program.args);
}

function makeFileOrDir(targetpath){
  var basedir=path.dirname(targetpath);
  if(path.extname(targetpath)){
   //文件 
    makedir_p(basedir);
  }else{
    makedir_p(targetpath);
  }
}
function isFile(targetpath){
  return !!path.extname(targetpath);
}
function makedir_p(targetpath){
  // /a/b/c/d
  console.log('makedir_p',targetpath);
  var ps=path.normalize(targetpath).split('/');
  console.log(ps);
  ps.forEach(function(e,i){
    //console.log('e',i,e,ps.slice(0,i).join('/'));
    if(e){
      var p=path.normalize('/'+ps.slice(0,i).join('/'));
      //console.log('p',p);
      if(!fs.existsSync(p)){
        fs.mkdirSync(p);
      }
    }
    return true;
  });
}
function doProcess(output,rules,files){
  /**
   * 单一文件还是文件列表
   * 如果是单一文件,
   * 目标位置是否存在
   * 目标是否目录
   *    创建目标目录
   *
   */
  var destpath=path.resolve(output);
  var exists=fs.existsSync(destpath);
  var outputs=[];
  if(files.length==1){
    if(!isFile(destpath)){
     destpath=path.join(destpath,path.basename(files[0])); 
    }
    outputs=[destpath]; 
  }else{
    files.forEach(function(file,i){
      outputs.push(path.join(destpath,path.basename(file)));
    });
  }
  makeFileOrDir(destpath);
  files=files.map(function(file,i){
      return path.resolve(CWD,file);
      });

  files.forEach(function(file,i){
      doWork(outputs[i],rules,file);
      });

}

function doWork(output,rules,file){
  console.log(output,rules,file);
  fs.createReadStream(file)
    .pipe(through2(function(chunk,enc,callback){
          //
          var after=chunk;
          this.push(after);
          callback();
          })).pipe(fs.createWriteStream(output));
}
