# content
## beofore や afterで
::beforeや::afterは対象となる要素のコンテンツの先頭および末尾に疑似的に要素を追加するものです。

```
<style>
    div::before{
        content: 'abc';
    }
</style>
<div>def</div>
```
は

```
<div><div::before />def</div>
```
であり
```
<div>abcdef</div>
```
となります。そのため、コンテンツを持たない<input/> <img/> <hr/>などには使えません。

http://ja.stackoverflow.com/questions/17819/inputtype-checkbox-%E3%81%AB%E5%AF%BE%E3%81%97%E3%81%A6-before-after-%E7%96%91%E4%BC%BC%E8%A6%81%E7%B4%A0%E3%81%8C%E4%BD%BF%E3%81%88%E3%82%8B%E3%81%AE%E3%81%AFchrome%E3%81%A0%E3%81%91
