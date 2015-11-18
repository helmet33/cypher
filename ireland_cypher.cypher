CREATE (Eire:Country {name: 'Eire'}),
       (UK:Country {name: 'UK'});

///////////// PROVINCES ////////////////////////////

CREATE (Leinster:Province {name: 'Leinster'}),
       (Munster:Province {name: 'Munster'}),
       (Connaught:Province {name: 'Connaught'}),
       (Ulster:Province {name: 'Ulster'});

//////////////// COUNTIES //////////////////////////

CREATE (Galway:County {name: "Galway"}),
       (Mayo:County {name: "Mayo"}),
       (Roscommon:County {name: "Roscommon"}),
       (Leitrim:County {name: "Leitrim"}),
       (Sligo:County {name: "Sligo"}),
       (Cork:County {name: "Cork"}),
       (Kerry:County {name: "Kerry"}),
       (Limerick:County {name: "Limerick"}),
       (Tipperary:County {name: "Tipperary"}),
       (Clare:County {name: "Clare"}),
       (Waterford:County {name: "Waterford"}),
       (Dublin:County {name: "Dublin"}),
       (Kildare:County {name: "Kildare"}),
       (Laois:County {name: "Laois"}),
       (Offaly:County {name: "Offaly"}),
       (Kilkenny:County {name: "Kilkenny"}),
       (Wexford:County {name: "Wexford"}),
       (Wicklow:County {name: "Wicklow"}),
       (Meath:County {name: "Meath"}),
       (Westmeath:County {name: "Westmeath"}),
       (Louth:County {name: "Louth"}),
       (Longford:County {name: "Longford"}),
       (Carlow:County {name: "Carlow"}),
       (Cavan:County {name: "Cavan"}),
       (Monaghan:County {name: "Monaghan"}),
       (Donegal:County {name: "Donegal"}),
       (Derry:County {name: "Derry"}),
       (Fermanagh:County {name: "Fermanagh"}),
       (Tyrone:County {name: "Tyrone"}),
       (Armagh:County {name: "Armagh"}),
       (Antrim:County {name: "Antrim"}),
       (Down:County {name: "Down"});


////////////////  CREATE RELATIONSHIPS FOR PROVINCES ///////////////////////////

MATCH
        (county:County),(province:Province)
WHERE
      county.name IN ['Galway','Mayo','Sligo','Roscommon','Leitrim']
      AND province.name = 'Connaught'
CREATE
      (county)-[county_in:IN_PROVINCE_OF]->(province)
RETURN
      county_in;




MATCH
        (county:County),(province:Province)
WHERE
      county.name IN ['Cork','Kerry','Clare','Waterford','Tipperary','Limerick']
      AND province.name = 'Munster'
CREATE
      (county)-[county_in:IN_PROVINCE_OF]->(province)
RETURN
      county_in;





MATCH
        (county:County),(province:Province)
WHERE
      county.name IN ['Dublin','Kildare','Laois','Offaly','Kilkenny','Wexford','Wicklow','Meath','Westmeath','Louth','Longford','Carlow']
      AND province.name = 'Leinster'
CREATE
      (county)-[county_in:IN_PROVINCE_OF]->(province)
RETURN
      county_in;


MATCH
        (county:County),(province:Province)
WHERE
      county.name IN ['Donegal','Derry','Fermanagh','Tyrone','Armagh','Antrim','Down','Cavan','Monaghan']
      AND province.name = 'Ulster'
CREATE
      (county)-[county_in:IN_PROVINCE_OF]->(province)
RETURN
      county_in;



/////////////// COUNTRY MAPPING /////////////////////

MATCH
        (county:County),(country:Country)
WHERE
      county.name IN ['Down','Antrim','Armagh','Fermanagh','Tyrone','Derry']
      AND country.name = 'UK'
CREATE
      (county)-[country_in:IN_COUNTRY_OF]->(country)
RETURN
      country_in;



MATCH
        (county:County),(country:Country)
WHERE
      county.name IN ['Cork','Kerry','Clare','Waterford','Tipperary','Limerick']
      AND country.name = 'Eire'
CREATE
      (county)-[country_in:IN_COUNTRY_OF]->(country)
RETURN
      country_in;

MATCH
        (county:County),(country:Country)
WHERE
      county.name IN ['Dublin','Kildare','Laois','Offaly','Kilkenny','Wexford','Wicklow','Meath','Westmeath','Louth','Longford','Carlow']
      AND country.name = 'Eire'
CREATE
      (county)-[country_in:IN_COUNTRY_OF]->(country)
RETURN
      country_in;

MATCH
        (county:County),(country:Country)
WHERE
      county.name IN ['Galway','Mayo','Sligo','Roscommon','Leitrim']
      AND country.name = 'Eire'
CREATE
      (county)-[country_in:IN_COUNTRY_OF]->(country)
RETURN
      country_in


MATCH
        (county:County),(country:Country)
WHERE
      county.name IN ['Donegal','Cavan','Monaghan']
      AND country.name = 'Eire'
CREATE
      (county)-[country_in:IN_COUNTRY_OF]->(country)
RETURN
      country_in

////////////// Single property add (Population) ///////

MATCH
  (county:County) WHERE county.name = 'Galway' SET county.population=250541 return n;


///////////// Read Population csv and update or create population property //////////
///// Windows --- file:c:/path/to/ireland_pop.csv
///// Linux Mac as below

LOAD CSV FROM "file:///path/to/file/ireland_pop.csv" AS csvLine
MATCH (county:County { name: csvLine[0]})
set county.population=toInt(csvLine[1]);
