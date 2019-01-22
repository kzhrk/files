module.exports = function(api) {
  api.cache(true);
  
  return {
    presets: [
      ["@babel/preset-env", {
        targets: {
          browsers: [
            "ie >= 11",
            "android >= 4"
          ]
        },
        useBuiltIns: "usage"
      }]
    ],
    plugins: [
      require("@babel/plugin-syntax-object-rest-spread")
    ]
  }
};
