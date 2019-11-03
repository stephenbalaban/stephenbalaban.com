---
title: "FOAF - Friend of a Friend - Machine readable people"
date: "2010-12-11"
---

So, I just created my first FOAF file using [http://www.ldodds.com/foaf/foaf-a-matic](http://www.ldodds.com/foaf/foaf-a-matic).

```
<rdf:RDF
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
 xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
 xmlns:foaf="http://xmlns.com/foaf/0.1/"
 xmlns:admin="http://webns.net/mvcb/">

 <foaf:PersonalProfileDocument rdf:about="">
  <foaf:maker rdf:resource="#me"/>
  <foaf:primaryTopic rdf:resource="#me"/>
  <admin:generatorAgent rdf:resource="http://www.ldodds.com/foaf/foaf-a-matic"/>
  <admin:errorReportsTo rdf:resource="mailto:leigh@ldodds.com"/>
 </foaf:PersonalProfileDocument>

 <foaf:Person rdf:ID="me">
 <foaf:name>Stephen Balaban</foaf:name>
 <foaf:givenname>Stephen</foaf:givenname>
 <foaf:family\_name>Balaban</foaf:family\_name>
 <foaf:nick>Steve</foaf:nick>
 <foaf:mbox\_sha1sum>a245f1ad98c749cca35b14a078581654e7a48faa</foaf:mbox\_sha1sum>
 <foaf:homepage rdf:resource="http://www.stephenbalaban.com/"/>
 <foaf:workplaceHomepage rdf:resource="http://www.yuanfenflow.com/"/>
 <foaf:workInfoHomepage rdf:resource="http://www.yuanfenflow.com/en/people/stephen-balaban/"/>
 <foaf:schoolHomepage rdf:resource="http://www.umich.edu/"/></foaf:Person>
</rdf:RDF>
```
