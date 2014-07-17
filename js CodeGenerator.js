function generator(json) {
	var str = "";
	for (var key in json) {
		if (typeof json[key] === 'number')
			if (json[key].toString().indexOf('.') < 0)
				str += "public int " + key + " {set;get;}\n";
			else
				str += "public float " + key + " {set;get;}\n";
		if (typeof json[key] === 'string')
			if (json[key].indexOf("Date") < 0)
				str += "public string " + key + " {set;get;}\n";
			else
				str += "public DateTime " + key + " {set;get;}\n";
		if (typeof json[key] === 'object')
			str += "public DateTime " + key + " {set;get;}\n";
		if (typeof json[key] === 'boolean')
			str += "public bool " + key + " {set;get;}\n";

	}
	return str;
}
