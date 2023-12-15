; extends

; Don't spell check annotations
[
 "@param"
] @nospell

; Don't spell check type names
((type) @nospell)

; Don't spell check parameter names
((param_annotation (identifier) @nospell))
