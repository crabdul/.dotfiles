module.exports = {
    env: {
        node: true,
        es6: true
    },

    parserOptions: {
        ecmaVersion: 2017
    },

    extends: [
        // Use 'eslint:recommended' as a base
        "eslint:recommended",
        "plugin:react/recommended"
        // Turn off all rules that are unnecessary or might conflict with prettier
        require.resolve("eslint-config-prettier")
    ],

    plugins: [
        // Use prettier for code format
        "eslint-plugin-prettier"
    ],

    rules: {
        "no-unused-vars": [
            "error",
            {
                vars: "all",
                args: "none",
                ignoreRestSiblings: true
            }
        ],
        // Prettier settings
        "prettier/prettier": [
            "error",
            {
                printWidth: 80,
                tabWidth: 4,
                useTabs: false,
                semi: true,
                singleQuote: true,
                trailingComma: "es5",
                bracketSpacing: true,
                jsxBracketSameLine: false,
                rangeStart: 0,
                rangeEnd: Infinity
            }
        ]
    }
};
