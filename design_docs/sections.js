{
   "by_title": {
       "map": "function(doc) {\n  if (doc.type == \"Section\") {\n    emit(doc.title, doc);\n  }\n}"
   },
   "by_notebook": {
       "map": "function(doc) {\n  if (doc.type == \"Section\" && doc.notebook) {\n    emit(doc.notebook, doc);\n  }\n}"
   },
   "by_tag": {
       "map": "function(doc) {\n  if (doc.type == \"Section\" && doc.tags) {\n    for (index in doc.tags) {\n       emit(doc.tags[index], doc);\n    }\n  }\n}"
   }
}