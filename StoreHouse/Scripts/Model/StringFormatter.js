var StringFormatter = {
    Format: function (str, params) {
        if (params) {
            for (var i = 0; i < params.length; i++) {
                if (str.indexOf("{" + i + "}")) {
                    str = str.replace("{" + i + "}", params[i]);
                } else {
                    break;
                }
            }

        }
        return str;
    }
}