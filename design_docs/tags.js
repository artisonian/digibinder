{
   "total": {
       "map": "function(doc) {\n  if (doc.type == \"Section\" && doc.tags) {\n    for (index in doc.tags) {\n      emit(doc.tags[index], 1);\n    }\n  }\n}",
       "reduce": "function(keys, values) {\n  return {\"tag\": keys[0][0], \"total\": sum(values)};\n}"
   }
}