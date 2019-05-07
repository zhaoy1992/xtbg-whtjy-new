Ext.data.XmlStringReader = function(meta, recordType){
    meta = meta || {};
    Ext.data.XmlStringReader.superclass.constructor.call(this, meta, recordType || meta.fields);
};
Ext.extend(Ext.data.XmlStringReader, Ext.data.DataReader, {
    /**
     * This method is only used by a DataProxy which has retrieved data from a remote server.
     * @param {Object} response The XHR object which contains the parsed XML document.  The response is expected
     * to contain a property called <tt>responseXML</tt> which refers to an XML document object.
     * @return {Object} records A data block which is used by an {@link Ext.data.Store} as
     * a cache of Ext.data.Records.
     */
    read : function(response){
        var strText = response.responseText;
        if(!strText) {
            throw {message: "XmlReader.read: XML Document not available"};
        }
        return this.readRecords(strText);
    },

    
    /**
    *    Ext.data.XmlStringReader.parseText
    *    将strText字符串解析为XMLDocument对象
    */
    parseText : function(strText)
    {
        
        var xmlDom = null;
        if(null != strText)
        {
            try //Internet Explorer
            {
              xmlDom=new ActiveXObject("Microsoft.XMLDOM");
            }
            catch(e)
            {
              try //Firefox, Mozilla, Opera, etc.
                {
                    xmlDom=document.implementation.createDocument("","",null);
                }
              catch(e) {throw {message: e.message};}
            }
            
            try 
            {
                  xmlDom.async = "true";
    　　            xmlDom.loadXML(strText);
            }catch(e) {throw {message: e.message};}
        }

        return xmlDom;
    },
    
    /**
     * Create a data block containing Ext.data.Records from an XML document.
     * @param {Object} doc A parsed XML document.
     * @return {Object} records A data block which is used by an {@link Ext.data.Store} as
     * a cache of Ext.data.Records.
     */
    readRecords : function(strText){
        /**
         * After any data loads/reads, the raw XML Document is available for further custom processing.
         * @type XMLDocument
         */
         
        var doc = this.parseText(strText);
        //doc.save('c:\temp.xml');
        //var tmproot = doc.documentElement;
           //alert('XML rows:'+  tmproot.childNodes.length);
        
        this.xmlData = doc;
        var root = doc.documentElement || doc;
        var q = Ext.DomQuery;
        var recordType = this.recordType;
        var fields = recordType.prototype.fields;
        var sid = this.meta.id;
        var totalRecords = 0, success = true;
        if(this.meta.totalRecords){
            totalRecords = q.selectNumber(this.meta.totalRecords, root, 0);
        }

        if(this.meta.success){
            var sv = q.selectValue(this.meta.success, root, true);
            success = sv !== false && sv !== 'false';
        }
        var records = [];
        var ns = q.select(this.meta.record, root);
        for(var i = 0, len = ns.length; i < len; i++) {
            var n = ns[i];
            var values = {};
            var id = sid ? q.selectValue(sid, n) : undefined;
            for(var j = 0, jlen = fields.length; j < jlen; j++){
                var f = fields.items[j];
                var v = q.selectValue(f.mapping || f.name, n, f.defaultValue);
                v = f.convert(v, n);
                values[f.name] = v;
            }
            var record = new recordType(values, id);
            record.node = n;
            records[records.length] = record;
        }

        return {
            success : success,
            records : records,
            totalRecords : totalRecords || records.length
        };
    }
});