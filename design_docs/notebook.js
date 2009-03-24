{
   "by_topic": {
       "map": "function(doc) {\n  if (doc.type == \"Notebook\") {\n    emit(doc.topic, doc);\n  }\n}"
   }
}