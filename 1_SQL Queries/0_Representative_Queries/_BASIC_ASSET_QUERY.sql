SELECT a.ASSETNUM, 
a.SERIALNUM, 
a.LOCATION, 
a.description AS ASSET_DESCRIPTON, 
c.description AS STRUCTURE_CLASS, 
VENDOR, MANUFACTURER, ASSETTAG, 
a.STATUS, 
a.STATE, 
a.STATUSDATE, 
a.changedate AS ASSET_CHANGEDATE, 
a.ZZMAKE, 
a.ZZMODELNUM, 
b.ASSETNUM, 
d.description AS ATTRIBUTE_TYPE, 
b.ALNVALUE,
b.CHANGEDATE AS SPEC_CHANGEDATE

FROM maximo.ASSET a,
maximo.assetspec b,
maximo.CLASSSTRUCTURE c,
maximo.ASSETATTRIBUTE d

WHERE a.assetnum = b.assetnum
AND b.classstructureid = c.classstructureid
AND b.assetattrid = d.assetattrid