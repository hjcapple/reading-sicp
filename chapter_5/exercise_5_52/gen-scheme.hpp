lookup_variable_value(val , symbol (tmp , "apply") , env);
define_variable(symbol (tmp ,  "apply-in-underlying-scheme") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1) , env);
goto after_lambda2;
entry1:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  2 , "exp" , "env" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "self-evaluating?") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch6;
};
compiled_branch7:
label(continue_ , && after_call8);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch6:
apply_primitive_procedure(val , proc , argl);
after_call8:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch4;
};
true_branch3:
lookup_variable_value(val , symbol (tmp , "exp") , env);
goto*label_get(continue_);
false_branch4:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "variable?") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch12;
};
compiled_branch13:
label(continue_ , && after_call14);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch12:
apply_primitive_procedure(val , proc , argl);
after_call14:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch10;
};
true_branch9:
lookup_variable_value(proc , symbol (tmp , "lookup-variable-value") , env);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "exp") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch15;
};
compiled_branch16:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch15:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call17:
false_branch10:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "quoted?") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch21;
};
compiled_branch22:
label(continue_ , && after_call23);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch21:
apply_primitive_procedure(val , proc , argl);
after_call23:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch19;
};
true_branch18:
lookup_variable_value(proc , symbol (tmp , "text-of-quotation") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch24;
};
compiled_branch25:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch24:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call26:
false_branch19:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "assignment?") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch30;
};
compiled_branch31:
label(continue_ , && after_call32);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch30:
apply_primitive_procedure(val , proc , argl);
after_call32:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch28;
};
true_branch27:
lookup_variable_value(proc , symbol (tmp , "eval-assignment") , env);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "exp") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch33;
};
compiled_branch34:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch33:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call35:
false_branch28:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "definition?") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch39;
};
compiled_branch40:
label(continue_ , && after_call41);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch39:
apply_primitive_procedure(val , proc , argl);
after_call41:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch37;
};
true_branch36:
lookup_variable_value(proc , symbol (tmp , "eval-definition") , env);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "exp") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch42;
};
compiled_branch43:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch42:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call44:
false_branch37:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "if?") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch48;
};
compiled_branch49:
label(continue_ , && after_call50);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch48:
apply_primitive_procedure(val , proc , argl);
after_call50:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch46;
};
true_branch45:
lookup_variable_value(proc , symbol (tmp , "eval-if") , env);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "exp") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch51;
};
compiled_branch52:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch51:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call53:
false_branch46:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "lambda?") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch57;
};
compiled_branch58:
label(continue_ , && after_call59);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch57:
apply_primitive_procedure(val , proc , argl);
after_call59:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch55;
};
true_branch54:
lookup_variable_value(proc , symbol (tmp , "make-procedure") , env);
save(continue_);
save(proc);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "lambda-body") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch63;
};
compiled_branch64:
label(continue_ , && after_call65);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch63:
apply_primitive_procedure(val , proc , argl);
after_call65:
restore(argl);
cons(argl , val , argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "lambda-parameters") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch60;
};
compiled_branch61:
label(continue_ , && after_call62);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch60:
apply_primitive_procedure(val , proc , argl);
after_call62:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch66;
};
compiled_branch67:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch66:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call68:
false_branch55:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "begin?") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch72;
};
compiled_branch73:
label(continue_ , && after_call74);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch72:
apply_primitive_procedure(val , proc , argl);
after_call74:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch70;
};
true_branch69:
lookup_variable_value(proc , symbol (tmp , "eval-sequence") , env);
save(continue_);
save(proc);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "begin-actions") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch75;
};
compiled_branch76:
label(continue_ , && after_call77);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch75:
apply_primitive_procedure(val , proc , argl);
after_call77:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch78;
};
compiled_branch79:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch78:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call80:
false_branch70:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "cond?") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch84;
};
compiled_branch85:
label(continue_ , && after_call86);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch84:
apply_primitive_procedure(val , proc , argl);
after_call86:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch82;
};
true_branch81:
lookup_variable_value(proc , symbol (tmp , "eval") , env);
save(continue_);
save(proc);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "cond->if") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch87;
};
compiled_branch88:
label(continue_ , && after_call89);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch87:
apply_primitive_procedure(val , proc , argl);
after_call89:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch90;
};
compiled_branch91:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch90:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call92:
false_branch82:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "let?") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch96;
};
compiled_branch97:
label(continue_ , && after_call98);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch96:
apply_primitive_procedure(val , proc , argl);
after_call98:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch94;
};
true_branch93:
lookup_variable_value(proc , symbol (tmp , "eval") , env);
save(continue_);
save(proc);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "let->combination") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch99;
};
compiled_branch100:
label(continue_ , && after_call101);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch99:
apply_primitive_procedure(val , proc , argl);
after_call101:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch102;
};
compiled_branch103:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch102:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call104:
false_branch94:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "application?") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch108;
};
compiled_branch109:
label(continue_ , && after_call110);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch108:
apply_primitive_procedure(val , proc , argl);
after_call110:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch106;
};
true_branch105:
lookup_variable_value(proc , symbol (tmp , "apply") , env);
save(continue_);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "list-of-values") , env);
save(proc);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "operands") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch117;
};
compiled_branch118:
label(continue_ , && after_call119);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch117:
apply_primitive_procedure(val , proc , argl);
after_call119:
restore(argl);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch120;
};
compiled_branch121:
label(continue_ , && after_call122);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch120:
apply_primitive_procedure(val , proc , argl);
after_call122:
null(argl);
cons(argl , val ,  argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "eval") , env);
save(proc);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "operator") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch111;
};
compiled_branch112:
label(continue_ , && after_call113);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch111:
apply_primitive_procedure(val , proc , argl);
after_call113:
restore(argl);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch114;
};
compiled_branch115:
label(continue_ , && after_call116);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch114:
apply_primitive_procedure(val , proc , argl);
after_call116:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch123;
};
compiled_branch124:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch123:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call125:
false_branch106:
lookup_variable_value(proc , symbol (tmp , "error") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
str(val , "Unknown expression type -- EVAL");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch126;
};
compiled_branch127:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch126:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call128:
after_if107:
after_if95:
after_if83:
after_if71:
after_if56:
after_if47:
after_if38:
after_if29:
after_if20:
after_if11:
after_if5:
after_lambda2:
define_variable(symbol (tmp ,  "eval") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry129) , env);
goto after_lambda130;
entry129:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  2 , "procedure" , "arguments" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "primitive-procedure?") , env);
lookup_variable_value(val , symbol (tmp , "procedure") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch134;
};
compiled_branch135:
label(continue_ , && after_call136);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch134:
apply_primitive_procedure(val , proc , argl);
after_call136:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch132;
};
true_branch131:
lookup_variable_value(proc , symbol (tmp , "apply-primitive-procedure") , env);
lookup_variable_value(val , symbol (tmp , "arguments") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "procedure") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch137;
};
compiled_branch138:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch137:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call139:
false_branch132:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "compound-procedure?") , env);
lookup_variable_value(val , symbol (tmp , "procedure") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch143;
};
compiled_branch144:
label(continue_ , && after_call145);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch143:
apply_primitive_procedure(val , proc , argl);
after_call145:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch141;
};
true_branch140:
lookup_variable_value(proc , symbol (tmp , "eval-sequence") , env);
save(continue_);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "extend-environment") , env);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "procedure-environment") , env);
lookup_variable_value(val , symbol (tmp , "procedure") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch152;
};
compiled_branch153:
label(continue_ , && after_call154);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch152:
apply_primitive_procedure(val , proc , argl);
after_call154:
null(argl);
cons(argl , val ,  argl);
restore(env);
lookup_variable_value(val , symbol (tmp , "arguments") , env);
cons(argl , val , argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "procedure-parameters") , env);
lookup_variable_value(val , symbol (tmp , "procedure") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch149;
};
compiled_branch150:
label(continue_ , && after_call151);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch149:
apply_primitive_procedure(val , proc , argl);
after_call151:
restore(argl);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch155;
};
compiled_branch156:
label(continue_ , && after_call157);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch155:
apply_primitive_procedure(val , proc , argl);
after_call157:
null(argl);
cons(argl , val ,  argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "procedure-body") , env);
lookup_variable_value(val , symbol (tmp , "procedure") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch146;
};
compiled_branch147:
label(continue_ , && after_call148);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch146:
apply_primitive_procedure(val , proc , argl);
after_call148:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch158;
};
compiled_branch159:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch158:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call160:
false_branch141:
lookup_variable_value(proc , symbol (tmp , "error") , env);
lookup_variable_value(val , symbol (tmp , "procedure") , env);
null(argl);
cons(argl , val ,  argl);
str(val , "Unknown procedure type -- APPLY");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch161;
};
compiled_branch162:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch161:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call163:
after_if142:
after_if133:
after_lambda130:
define_variable(symbol (tmp ,  "apply") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry164) , env);
goto after_lambda165;
entry164:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  2 , "exps" , "env" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "no-operands?") , env);
lookup_variable_value(val , symbol (tmp , "exps") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch169;
};
compiled_branch170:
label(continue_ , && after_call171);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch169:
apply_primitive_procedure(val , proc , argl);
after_call171:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch167;
};
true_branch166:
null(val);
goto*label_get(continue_);
false_branch167:
lookup_variable_value(proc , symbol (tmp , "cons") , env);
save(continue_);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "list-of-values") , env);
save(proc);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "rest-operands") , env);
lookup_variable_value(val , symbol (tmp , "exps") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch178;
};
compiled_branch179:
label(continue_ , && after_call180);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch178:
apply_primitive_procedure(val , proc , argl);
after_call180:
restore(argl);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch181;
};
compiled_branch182:
label(continue_ , && after_call183);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch181:
apply_primitive_procedure(val , proc , argl);
after_call183:
null(argl);
cons(argl , val ,  argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "eval") , env);
save(proc);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "first-operand") , env);
lookup_variable_value(val , symbol (tmp , "exps") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch172;
};
compiled_branch173:
label(continue_ , && after_call174);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch172:
apply_primitive_procedure(val , proc , argl);
after_call174:
restore(argl);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch175;
};
compiled_branch176:
label(continue_ , && after_call177);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch175:
apply_primitive_procedure(val , proc , argl);
after_call177:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch184;
};
compiled_branch185:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch184:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call186:
after_if168:
after_lambda165:
define_variable(symbol (tmp ,  "list-of-values") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry187) , env);
goto after_lambda188;
entry187:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  2 , "exp" , "env" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "true?") , env);
save(proc);
lookup_variable_value(proc , symbol (tmp , "eval") , env);
save(proc);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "if-predicate") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch192;
};
compiled_branch193:
label(continue_ , && after_call194);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch192:
apply_primitive_procedure(val , proc , argl);
after_call194:
restore(argl);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch195;
};
compiled_branch196:
label(continue_ , && after_call197);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch195:
apply_primitive_procedure(val , proc , argl);
after_call197:
null(argl);
cons(argl , val ,  argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch198;
};
compiled_branch199:
label(continue_ , && after_call200);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch198:
apply_primitive_procedure(val , proc , argl);
after_call200:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch190;
};
true_branch189:
lookup_variable_value(proc , symbol (tmp , "eval") , env);
save(continue_);
save(proc);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "if-consequent") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch201;
};
compiled_branch202:
label(continue_ , && after_call203);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch201:
apply_primitive_procedure(val , proc , argl);
after_call203:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch204;
};
compiled_branch205:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch204:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call206:
false_branch190:
lookup_variable_value(proc , symbol (tmp , "eval") , env);
save(continue_);
save(proc);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "if-alternative") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch207;
};
compiled_branch208:
label(continue_ , && after_call209);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch207:
apply_primitive_procedure(val , proc , argl);
after_call209:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch210;
};
compiled_branch211:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch210:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call212:
after_if191:
after_lambda188:
define_variable(symbol (tmp ,  "eval-if") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry213) , env);
goto after_lambda214;
entry213:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  2 , "exps" , "env" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "last-exp?") , env);
lookup_variable_value(val , symbol (tmp , "exps") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch218;
};
compiled_branch219:
label(continue_ , && after_call220);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch218:
apply_primitive_procedure(val , proc , argl);
after_call220:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch216;
};
true_branch215:
lookup_variable_value(proc , symbol (tmp , "eval") , env);
save(continue_);
save(proc);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "first-exp") , env);
lookup_variable_value(val , symbol (tmp , "exps") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch221;
};
compiled_branch222:
label(continue_ , && after_call223);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch221:
apply_primitive_procedure(val , proc , argl);
after_call223:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch224;
};
compiled_branch225:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch224:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call226:
false_branch216:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "eval") , env);
save(proc);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "first-exp") , env);
lookup_variable_value(val , symbol (tmp , "exps") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch227;
};
compiled_branch228:
label(continue_ , && after_call229);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch227:
apply_primitive_procedure(val , proc , argl);
after_call229:
restore(argl);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch230;
};
compiled_branch231:
label(continue_ , && after_call232);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch230:
apply_primitive_procedure(val , proc , argl);
after_call232:
restore(env);
restore(continue_);
lookup_variable_value(proc , symbol (tmp , "eval-sequence") , env);
save(continue_);
save(proc);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "rest-exps") , env);
lookup_variable_value(val , symbol (tmp , "exps") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch233;
};
compiled_branch234:
label(continue_ , && after_call235);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch233:
apply_primitive_procedure(val , proc , argl);
after_call235:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch236;
};
compiled_branch237:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch236:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call238:
after_if217:
after_lambda214:
define_variable(symbol (tmp ,  "eval-sequence") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry239) , env);
goto after_lambda240;
entry239:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  2 , "exp" , "env" )) , argl , env);
save(continue_);
lookup_variable_value(proc , symbol (tmp , "set-variable-value!") , env);
save(proc);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "eval") , env);
save(proc);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "assignment-value") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch244;
};
compiled_branch245:
label(continue_ , && after_call246);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch244:
apply_primitive_procedure(val , proc , argl);
after_call246:
restore(argl);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch247;
};
compiled_branch248:
label(continue_ , && after_call249);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch247:
apply_primitive_procedure(val , proc , argl);
after_call249:
restore(argl);
cons(argl , val , argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "assignment-variable") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch241;
};
compiled_branch242:
label(continue_ , && after_call243);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch241:
apply_primitive_procedure(val , proc , argl);
after_call243:
restore(argl);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch250;
};
compiled_branch251:
label(continue_ , && after_call252);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch250:
apply_primitive_procedure(val , proc , argl);
after_call252:
restore(continue_);
symbol(val , "ok");
goto*label_get(continue_);
after_lambda240:
define_variable(symbol (tmp ,  "eval-assignment") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry253) , env);
goto after_lambda254;
entry253:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  2 , "exp" , "env" )) , argl , env);
save(continue_);
lookup_variable_value(proc , symbol (tmp , "define-variable!") , env);
save(proc);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "eval") , env);
save(proc);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "definition-value") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch258;
};
compiled_branch259:
label(continue_ , && after_call260);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch258:
apply_primitive_procedure(val , proc , argl);
after_call260:
restore(argl);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch261;
};
compiled_branch262:
label(continue_ , && after_call263);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch261:
apply_primitive_procedure(val , proc , argl);
after_call263:
restore(argl);
cons(argl , val , argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "definition-variable") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch255;
};
compiled_branch256:
label(continue_ , && after_call257);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch255:
apply_primitive_procedure(val , proc , argl);
after_call257:
restore(argl);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch264;
};
compiled_branch265:
label(continue_ , && after_call266);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch264:
apply_primitive_procedure(val , proc , argl);
after_call266:
restore(continue_);
symbol(val , "ok");
goto*label_get(continue_);
after_lambda254:
define_variable(symbol (tmp ,  "eval-definition") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry267) , env);
goto after_lambda268;
entry267:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "number?") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch272;
};
compiled_branch273:
label(continue_ , && after_call274);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch272:
apply_primitive_procedure(val , proc , argl);
after_call274:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch270;
};
true_branch269:
lookup_variable_value(val , symbol (tmp , "true") , env);
goto*label_get(continue_);
false_branch270:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "string?") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch278;
};
compiled_branch279:
label(continue_ , && after_call280);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch278:
apply_primitive_procedure(val , proc , argl);
after_call280:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch276;
};
true_branch275:
lookup_variable_value(val , symbol (tmp , "true") , env);
goto*label_get(continue_);
false_branch276:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "boolean?") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch284;
};
compiled_branch285:
label(continue_ , && after_call286);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch284:
apply_primitive_procedure(val , proc , argl);
after_call286:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch282;
};
true_branch281:
lookup_variable_value(val , symbol (tmp , "true") , env);
goto*label_get(continue_);
false_branch282:
lookup_variable_value(val , symbol (tmp , "false") , env);
goto*label_get(continue_);
after_if283:
after_if277:
after_if271:
after_lambda268:
define_variable(symbol (tmp ,  "self-evaluating?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry287) , env);
goto after_lambda288;
entry287:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "tagged-list?") , env);
symbol(val , "quote");
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "exp") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch289;
};
compiled_branch290:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch289:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call291:
after_lambda288:
define_variable(symbol (tmp ,  "quoted?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry292) , env);
goto after_lambda293;
entry292:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cadr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch294;
};
compiled_branch295:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch294:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call296:
after_lambda293:
define_variable(symbol (tmp ,  "text-of-quotation") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry297) , env);
goto after_lambda298;
entry297:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  2 , "exp" , "tag" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "pair?") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch302;
};
compiled_branch303:
label(continue_ , && after_call304);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch302:
apply_primitive_procedure(val , proc , argl);
after_call304:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch300;
};
true_branch299:
lookup_variable_value(proc , symbol (tmp , "eq?") , env);
save(continue_);
save(proc);
lookup_variable_value(val , symbol (tmp , "tag") , env);
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "car") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch305;
};
compiled_branch306:
label(continue_ , && after_call307);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch305:
apply_primitive_procedure(val , proc , argl);
after_call307:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch308;
};
compiled_branch309:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch308:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call310:
false_branch300:
lookup_variable_value(val , symbol (tmp , "false") , env);
goto*label_get(continue_);
after_if301:
after_lambda298:
define_variable(symbol (tmp ,  "tagged-list?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry311) , env);
goto after_lambda312;
entry311:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "symbol?") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch313;
};
compiled_branch314:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch313:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call315:
after_lambda312:
define_variable(symbol (tmp ,  "variable?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry316) , env);
goto after_lambda317;
entry316:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "tagged-list?") , env);
symbol(val , "set!");
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "exp") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch318;
};
compiled_branch319:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch318:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call320:
after_lambda317:
define_variable(symbol (tmp ,  "assignment?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry321) , env);
goto after_lambda322;
entry321:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cadr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch323;
};
compiled_branch324:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch323:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call325:
after_lambda322:
define_variable(symbol (tmp ,  "assignment-variable") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry326) , env);
goto after_lambda327;
entry326:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "caddr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch328;
};
compiled_branch329:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch328:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call330:
after_lambda327:
define_variable(symbol (tmp ,  "assignment-value") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry331) , env);
goto after_lambda332;
entry331:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "tagged-list?") , env);
symbol(val , "define");
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "exp") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch333;
};
compiled_branch334:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch333:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call335:
after_lambda332:
define_variable(symbol (tmp ,  "definition?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry336) , env);
goto after_lambda337;
entry336:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "symbol?") , env);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cadr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch341;
};
compiled_branch342:
label(continue_ , && after_call343);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch341:
apply_primitive_procedure(val , proc , argl);
after_call343:
null(argl);
cons(argl , val ,  argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch344;
};
compiled_branch345:
label(continue_ , && after_call346);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch344:
apply_primitive_procedure(val , proc , argl);
after_call346:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch339;
};
true_branch338:
lookup_variable_value(proc , symbol (tmp , "cadr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch347;
};
compiled_branch348:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch347:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call349:
false_branch339:
lookup_variable_value(proc , symbol (tmp , "caadr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch350;
};
compiled_branch351:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch350:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call352:
after_if340:
after_lambda337:
define_variable(symbol (tmp ,  "definition-variable") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry353) , env);
goto after_lambda354;
entry353:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "symbol?") , env);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cadr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch358;
};
compiled_branch359:
label(continue_ , && after_call360);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch358:
apply_primitive_procedure(val , proc , argl);
after_call360:
null(argl);
cons(argl , val ,  argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch361;
};
compiled_branch362:
label(continue_ , && after_call363);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch361:
apply_primitive_procedure(val , proc , argl);
after_call363:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch356;
};
true_branch355:
lookup_variable_value(proc , symbol (tmp , "caddr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch364;
};
compiled_branch365:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch364:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call366:
false_branch356:
lookup_variable_value(proc , symbol (tmp , "make-lambda") , env);
save(continue_);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "cddr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch370;
};
compiled_branch371:
label(continue_ , && after_call372);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch370:
apply_primitive_procedure(val , proc , argl);
after_call372:
null(argl);
cons(argl , val ,  argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "cdadr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch367;
};
compiled_branch368:
label(continue_ , && after_call369);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch367:
apply_primitive_procedure(val , proc , argl);
after_call369:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch373;
};
compiled_branch374:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch373:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call375:
after_if357:
after_lambda354:
define_variable(symbol (tmp ,  "definition-value") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry376) , env);
goto after_lambda377;
entry376:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "tagged-list?") , env);
symbol(val , "lambda");
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "exp") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch378;
};
compiled_branch379:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch378:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call380:
after_lambda377:
define_variable(symbol (tmp ,  "lambda?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry381) , env);
goto after_lambda382;
entry381:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cadr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch383;
};
compiled_branch384:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch383:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call385:
after_lambda382:
define_variable(symbol (tmp ,  "lambda-parameters") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry386) , env);
goto after_lambda387;
entry386:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cddr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch388;
};
compiled_branch389:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch388:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call390:
after_lambda387:
define_variable(symbol (tmp ,  "lambda-body") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry391) , env);
goto after_lambda392;
entry391:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  2 , "parameters" , "body" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cons") , env);
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cons") , env);
lookup_variable_value(val , symbol (tmp , "body") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "parameters") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch393;
};
compiled_branch394:
label(continue_ , && after_call395);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch393:
apply_primitive_procedure(val , proc , argl);
after_call395:
null(argl);
cons(argl , val ,  argl);
symbol(val , "lambda");
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch396;
};
compiled_branch397:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch396:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call398:
after_lambda392:
define_variable(symbol (tmp ,  "make-lambda") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry399) , env);
goto after_lambda400;
entry399:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "tagged-list?") , env);
symbol(val , "if");
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "exp") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch401;
};
compiled_branch402:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch401:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call403:
after_lambda400:
define_variable(symbol (tmp ,  "if?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry404) , env);
goto after_lambda405;
entry404:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cadr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch406;
};
compiled_branch407:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch406:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call408:
after_lambda405:
define_variable(symbol (tmp ,  "if-predicate") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry409) , env);
goto after_lambda410;
entry409:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "caddr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch411;
};
compiled_branch412:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch411:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call413:
after_lambda410:
define_variable(symbol (tmp ,  "if-consequent") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry414) , env);
goto after_lambda415;
entry414:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "not") , env);
save(proc);
lookup_variable_value(proc , symbol (tmp , "null?") , env);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cdddr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch419;
};
compiled_branch420:
label(continue_ , && after_call421);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch419:
apply_primitive_procedure(val , proc , argl);
after_call421:
null(argl);
cons(argl , val ,  argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch422;
};
compiled_branch423:
label(continue_ , && after_call424);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch422:
apply_primitive_procedure(val , proc , argl);
after_call424:
null(argl);
cons(argl , val ,  argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch425;
};
compiled_branch426:
label(continue_ , && after_call427);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch425:
apply_primitive_procedure(val , proc , argl);
after_call427:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch417;
};
true_branch416:
lookup_variable_value(proc , symbol (tmp , "cadddr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch428;
};
compiled_branch429:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch428:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call430:
false_branch417:
symbol(val , "false");
goto*label_get(continue_);
after_if418:
after_lambda415:
define_variable(symbol (tmp ,  "if-alternative") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry431) , env);
goto after_lambda432;
entry431:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  3 , "predicate" , "consequent" , "alternative" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "alternative") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "consequent") , env);
cons(argl , val , argl);
lookup_variable_value(val , symbol (tmp , "predicate") , env);
cons(argl , val , argl);
symbol(val , "if");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch433;
};
compiled_branch434:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch433:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call435:
after_lambda432:
define_variable(symbol (tmp ,  "make-if") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry436) , env);
goto after_lambda437;
entry436:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "tagged-list?") , env);
symbol(val , "begin");
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "exp") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch438;
};
compiled_branch439:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch438:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call440:
after_lambda437:
define_variable(symbol (tmp ,  "begin?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry441) , env);
goto after_lambda442;
entry441:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch443;
};
compiled_branch444:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch443:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call445:
after_lambda442:
define_variable(symbol (tmp ,  "begin-actions") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry446) , env);
goto after_lambda447;
entry446:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "seq" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "null?") , env);
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "seq") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch448;
};
compiled_branch449:
label(continue_ , && after_call450);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch448:
apply_primitive_procedure(val , proc , argl);
after_call450:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch451;
};
compiled_branch452:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch451:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call453:
after_lambda447:
define_variable(symbol (tmp ,  "last-exp?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry454) , env);
goto after_lambda455;
entry454:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "seq" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "car") , env);
lookup_variable_value(val , symbol (tmp , "seq") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch456;
};
compiled_branch457:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch456:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call458:
after_lambda455:
define_variable(symbol (tmp ,  "first-exp") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry459) , env);
goto after_lambda460;
entry459:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "seq" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "seq") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch461;
};
compiled_branch462:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch461:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call463:
after_lambda460:
define_variable(symbol (tmp ,  "rest-exps") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry464) , env);
goto after_lambda465;
entry464:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "seq" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "null?") , env);
lookup_variable_value(val , symbol (tmp , "seq") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch469;
};
compiled_branch470:
label(continue_ , && after_call471);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch469:
apply_primitive_procedure(val , proc , argl);
after_call471:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch467;
};
true_branch466:
lookup_variable_value(val , symbol (tmp , "seq") , env);
goto*label_get(continue_);
false_branch467:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "last-exp?") , env);
lookup_variable_value(val , symbol (tmp , "seq") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch475;
};
compiled_branch476:
label(continue_ , && after_call477);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch475:
apply_primitive_procedure(val , proc , argl);
after_call477:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch473;
};
true_branch472:
lookup_variable_value(proc , symbol (tmp , "first-exp") , env);
lookup_variable_value(val , symbol (tmp , "seq") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch478;
};
compiled_branch479:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch478:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call480:
false_branch473:
lookup_variable_value(proc , symbol (tmp , "make-begin") , env);
lookup_variable_value(val , symbol (tmp , "seq") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch481;
};
compiled_branch482:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch481:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call483:
after_if474:
after_if468:
after_lambda465:
define_variable(symbol (tmp ,  "sequence->exp") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry484) , env);
goto after_lambda485;
entry484:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "seq" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cons") , env);
lookup_variable_value(val , symbol (tmp , "seq") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "begin");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch486;
};
compiled_branch487:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch486:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call488:
after_lambda485:
define_variable(symbol (tmp ,  "make-begin") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry489) , env);
goto after_lambda490;
entry489:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "pair?") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch491;
};
compiled_branch492:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch491:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call493:
after_lambda490:
define_variable(symbol (tmp ,  "application?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry494) , env);
goto after_lambda495;
entry494:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "car") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch496;
};
compiled_branch497:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch496:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call498:
after_lambda495:
define_variable(symbol (tmp ,  "operator") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry499) , env);
goto after_lambda500;
entry499:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch501;
};
compiled_branch502:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch501:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call503:
after_lambda500:
define_variable(symbol (tmp ,  "operands") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry504) , env);
goto after_lambda505;
entry504:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "ops" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "null?") , env);
lookup_variable_value(val , symbol (tmp , "ops") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch506;
};
compiled_branch507:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch506:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call508:
after_lambda505:
define_variable(symbol (tmp ,  "no-operands?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry509) , env);
goto after_lambda510;
entry509:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "ops" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "car") , env);
lookup_variable_value(val , symbol (tmp , "ops") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch511;
};
compiled_branch512:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch511:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call513:
after_lambda510:
define_variable(symbol (tmp ,  "first-operand") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry514) , env);
goto after_lambda515;
entry514:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "ops" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "ops") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch516;
};
compiled_branch517:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch516:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call518:
after_lambda515:
define_variable(symbol (tmp ,  "rest-operands") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry519) , env);
goto after_lambda520;
entry519:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "tagged-list?") , env);
symbol(val , "cond");
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "exp") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch521;
};
compiled_branch522:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch521:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call523:
after_lambda520:
define_variable(symbol (tmp ,  "cond?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry524) , env);
goto after_lambda525;
entry524:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch526;
};
compiled_branch527:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch526:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call528:
after_lambda525:
define_variable(symbol (tmp ,  "cond-clauses") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry529) , env);
goto after_lambda530;
entry529:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "clause" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "eq?") , env);
save(continue_);
save(proc);
symbol(val , "else");
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "cond-predicate") , env);
lookup_variable_value(val , symbol (tmp , "clause") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch531;
};
compiled_branch532:
label(continue_ , && after_call533);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch531:
apply_primitive_procedure(val , proc , argl);
after_call533:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch534;
};
compiled_branch535:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch534:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call536:
after_lambda530:
define_variable(symbol (tmp ,  "cond-else-clause?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry537) , env);
goto after_lambda538;
entry537:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "clause" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "car") , env);
lookup_variable_value(val , symbol (tmp , "clause") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch539;
};
compiled_branch540:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch539:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call541:
after_lambda538:
define_variable(symbol (tmp ,  "cond-predicate") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry542) , env);
goto after_lambda543;
entry542:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "clause" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "clause") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch544;
};
compiled_branch545:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch544:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call546:
after_lambda543:
define_variable(symbol (tmp ,  "cond-actions") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry547) , env);
goto after_lambda548;
entry547:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "expand-clauses") , env);
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cond-clauses") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch549;
};
compiled_branch550:
label(continue_ , && after_call551);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch549:
apply_primitive_procedure(val , proc , argl);
after_call551:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch552;
};
compiled_branch553:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch552:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call554:
after_lambda548:
define_variable(symbol (tmp ,  "cond->if") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry555) , env);
goto after_lambda556;
entry555:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "tagged-list?") , env);
symbol(val , "let");
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "exp") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch557;
};
compiled_branch558:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch557:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call559:
after_lambda556:
define_variable(symbol (tmp ,  "let?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry560) , env);
goto after_lambda561;
entry560:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
make_compiled_procedure(val , label (tmp , && entry562) , env);
goto after_lambda563;
entry562:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cddr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch564;
};
compiled_branch565:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch564:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call566:
after_lambda563:
define_variable(symbol (tmp ,  "let-body") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry567) , env);
goto after_lambda568;
entry567:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "map") , env);
save(continue_);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "cadr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch569;
};
compiled_branch570:
label(continue_ , && after_call571);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch569:
apply_primitive_procedure(val , proc , argl);
after_call571:
null(argl);
cons(argl , val ,  argl);
restore(env);
lookup_variable_value(val , symbol (tmp , "car") , env);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch572;
};
compiled_branch573:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch572:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call574:
after_lambda568:
define_variable(symbol (tmp ,  "let-vars") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry575) , env);
goto after_lambda576;
entry575:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "exp" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "map") , env);
save(continue_);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "cadr") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch577;
};
compiled_branch578:
label(continue_ , && after_call579);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch577:
apply_primitive_procedure(val , proc , argl);
after_call579:
null(argl);
cons(argl , val ,  argl);
restore(env);
lookup_variable_value(val , symbol (tmp , "cadr") , env);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch580;
};
compiled_branch581:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch580:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call582:
after_lambda576:
define_variable(symbol (tmp ,  "let-exps") , val , env);
symbol(val , "ok");
lookup_variable_value(proc , symbol (tmp , "cons") , env);
save(continue_);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "let-exps") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch592;
};
compiled_branch593:
label(continue_ , && after_call594);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch592:
apply_primitive_procedure(val , proc , argl);
after_call594:
null(argl);
cons(argl , val ,  argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "make-lambda") , env);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "let-body") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch586;
};
compiled_branch587:
label(continue_ , && after_call588);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch586:
apply_primitive_procedure(val , proc , argl);
after_call588:
null(argl);
cons(argl , val ,  argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "let-vars") , env);
lookup_variable_value(val , symbol (tmp , "exp") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch583;
};
compiled_branch584:
label(continue_ , && after_call585);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch583:
apply_primitive_procedure(val , proc , argl);
after_call585:
restore(argl);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch589;
};
compiled_branch590:
label(continue_ , && after_call591);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch589:
apply_primitive_procedure(val , proc , argl);
after_call591:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch595;
};
compiled_branch596:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch595:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call597:
after_lambda561:
define_variable(symbol (tmp ,  "let->combination") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry598) , env);
goto after_lambda599;
entry598:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "clauses" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "null?") , env);
lookup_variable_value(val , symbol (tmp , "clauses") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch603;
};
compiled_branch604:
label(continue_ , && after_call605);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch603:
apply_primitive_procedure(val , proc , argl);
after_call605:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch601;
};
true_branch600:
symbol(val , "false");
goto*label_get(continue_);
false_branch601:
make_compiled_procedure(proc , label (tmp , && entry606) , env);
goto after_lambda607;
entry606:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  2 , "first" , "rest" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "cond-else-clause?") , env);
lookup_variable_value(val , symbol (tmp , "first") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch611;
};
compiled_branch612:
label(continue_ , && after_call613);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch611:
apply_primitive_procedure(val , proc , argl);
after_call613:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch609;
};
true_branch608:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "null?") , env);
lookup_variable_value(val , symbol (tmp , "rest") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch617;
};
compiled_branch618:
label(continue_ , && after_call619);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch617:
apply_primitive_procedure(val , proc , argl);
after_call619:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch615;
};
true_branch614:
lookup_variable_value(proc , symbol (tmp , "sequence->exp") , env);
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cond-actions") , env);
lookup_variable_value(val , symbol (tmp , "first") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch620;
};
compiled_branch621:
label(continue_ , && after_call622);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch620:
apply_primitive_procedure(val , proc , argl);
after_call622:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch623;
};
compiled_branch624:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch623:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call625:
false_branch615:
lookup_variable_value(proc , symbol (tmp , "error") , env);
lookup_variable_value(val , symbol (tmp , "clauses") , env);
null(argl);
cons(argl , val ,  argl);
str(val , "ELSE clause isn't last -- COND->IF");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch626;
};
compiled_branch627:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch626:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call628:
after_if616:
false_branch609:
lookup_variable_value(proc , symbol (tmp , "make-if") , env);
save(continue_);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "expand-clauses") , env);
lookup_variable_value(val , symbol (tmp , "rest") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch638;
};
compiled_branch639:
label(continue_ , && after_call640);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch638:
apply_primitive_procedure(val , proc , argl);
after_call640:
null(argl);
cons(argl , val ,  argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "sequence->exp") , env);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cond-actions") , env);
lookup_variable_value(val , symbol (tmp , "first") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch632;
};
compiled_branch633:
label(continue_ , && after_call634);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch632:
apply_primitive_procedure(val , proc , argl);
after_call634:
null(argl);
cons(argl , val ,  argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch635;
};
compiled_branch636:
label(continue_ , && after_call637);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch635:
apply_primitive_procedure(val , proc , argl);
after_call637:
restore(argl);
cons(argl , val , argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "cond-predicate") , env);
lookup_variable_value(val , symbol (tmp , "first") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch629;
};
compiled_branch630:
label(continue_ , && after_call631);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch629:
apply_primitive_procedure(val , proc , argl);
after_call631:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch641;
};
compiled_branch642:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch641:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call643:
after_if610:
after_lambda607:
save(continue_);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "clauses") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch647;
};
compiled_branch648:
label(continue_ , && after_call649);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch647:
apply_primitive_procedure(val , proc , argl);
after_call649:
null(argl);
cons(argl , val ,  argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "car") , env);
lookup_variable_value(val , symbol (tmp , "clauses") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch644;
};
compiled_branch645:
label(continue_ , && after_call646);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch644:
apply_primitive_procedure(val , proc , argl);
after_call646:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch650;
};
compiled_branch651:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch650:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call652:
after_if602:
after_lambda599:
define_variable(symbol (tmp ,  "expand-clauses") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry653) , env);
goto after_lambda654;
entry653:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "x" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "not") , env);
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "eq?") , env);
lookup_variable_value(val , symbol (tmp , "false") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "x") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch655;
};
compiled_branch656:
label(continue_ , && after_call657);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch655:
apply_primitive_procedure(val , proc , argl);
after_call657:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch658;
};
compiled_branch659:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch658:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call660:
after_lambda654:
define_variable(symbol (tmp ,  "true?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry661) , env);
goto after_lambda662;
entry661:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "x" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "eq?") , env);
lookup_variable_value(val , symbol (tmp , "false") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "x") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch663;
};
compiled_branch664:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch663:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call665:
after_lambda662:
define_variable(symbol (tmp ,  "false?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry666) , env);
goto after_lambda667;
entry666:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  3 , "parameters" , "body" , "env" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "body") , env);
cons(argl , val , argl);
lookup_variable_value(val , symbol (tmp , "parameters") , env);
cons(argl , val , argl);
symbol(val , "procedure");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch668;
};
compiled_branch669:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch668:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call670:
after_lambda667:
define_variable(symbol (tmp ,  "make-procedure") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry671) , env);
goto after_lambda672;
entry671:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "p" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "tagged-list?") , env);
symbol(val , "procedure");
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "p") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch673;
};
compiled_branch674:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch673:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call675:
after_lambda672:
define_variable(symbol (tmp ,  "compound-procedure?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry676) , env);
goto after_lambda677;
entry676:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "p" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cadr") , env);
lookup_variable_value(val , symbol (tmp , "p") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch678;
};
compiled_branch679:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch678:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call680:
after_lambda677:
define_variable(symbol (tmp ,  "procedure-parameters") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry681) , env);
goto after_lambda682;
entry681:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "p" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "caddr") , env);
lookup_variable_value(val , symbol (tmp , "p") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch683;
};
compiled_branch684:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch683:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call685:
after_lambda682:
define_variable(symbol (tmp ,  "procedure-body") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry686) , env);
goto after_lambda687;
entry686:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "p" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cadddr") , env);
lookup_variable_value(val , symbol (tmp , "p") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch688;
};
compiled_branch689:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch688:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call690:
after_lambda687:
define_variable(symbol (tmp ,  "procedure-environment") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry691) , env);
goto after_lambda692;
entry691:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "env" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch693;
};
compiled_branch694:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch693:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call695:
after_lambda692:
define_variable(symbol (tmp ,  "enclosing-environment") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry696) , env);
goto after_lambda697;
entry696:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "env" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "car") , env);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch698;
};
compiled_branch699:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch698:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call700:
after_lambda697:
define_variable(symbol (tmp ,  "first-frame") , val , env);
symbol(val , "ok");
null(val);
define_variable(symbol (tmp ,  "the-empty-environment") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry701) , env);
goto after_lambda702;
entry701:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  2 , "variables" , "values" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cons") , env);
lookup_variable_value(val , symbol (tmp , "values") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "variables") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch703;
};
compiled_branch704:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch703:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call705:
after_lambda702:
define_variable(symbol (tmp ,  "make-frame") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry706) , env);
goto after_lambda707;
entry706:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "frame" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "car") , env);
lookup_variable_value(val , symbol (tmp , "frame") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch708;
};
compiled_branch709:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch708:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call710:
after_lambda707:
define_variable(symbol (tmp ,  "frame-variables") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry711) , env);
goto after_lambda712;
entry711:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "frame" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "frame") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch713;
};
compiled_branch714:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch713:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call715:
after_lambda712:
define_variable(symbol (tmp ,  "frame-values") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry716) , env);
goto after_lambda717;
entry716:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  3 , "var" , "val" , "frame" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "set-car!") , env);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "cons") , env);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "car") , env);
lookup_variable_value(val , symbol (tmp , "frame") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch718;
};
compiled_branch719:
label(continue_ , && after_call720);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch718:
apply_primitive_procedure(val , proc , argl);
after_call720:
null(argl);
cons(argl , val ,  argl);
restore(env);
lookup_variable_value(val , symbol (tmp , "var") , env);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch721;
};
compiled_branch722:
label(continue_ , && after_call723);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch721:
apply_primitive_procedure(val , proc , argl);
after_call723:
null(argl);
cons(argl , val ,  argl);
restore(env);
lookup_variable_value(val , symbol (tmp , "frame") , env);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch724;
};
compiled_branch725:
label(continue_ , && after_call726);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch724:
apply_primitive_procedure(val , proc , argl);
after_call726:
restore(env);
restore(continue_);
lookup_variable_value(proc , symbol (tmp , "set-cdr!") , env);
save(continue_);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "cons") , env);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "frame") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch727;
};
compiled_branch728:
label(continue_ , && after_call729);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch727:
apply_primitive_procedure(val , proc , argl);
after_call729:
null(argl);
cons(argl , val ,  argl);
restore(env);
lookup_variable_value(val , symbol (tmp , "val") , env);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch730;
};
compiled_branch731:
label(continue_ , && after_call732);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch730:
apply_primitive_procedure(val , proc , argl);
after_call732:
null(argl);
cons(argl , val ,  argl);
restore(env);
lookup_variable_value(val , symbol (tmp , "frame") , env);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch733;
};
compiled_branch734:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch733:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call735:
after_lambda717:
define_variable(symbol (tmp ,  "add-binding-to-frame!") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry736) , env);
goto after_lambda737;
entry736:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  3 , "vars" , "vals" , "base-env" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "=") , env);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "length") , env);
lookup_variable_value(val , symbol (tmp , "vals") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch744;
};
compiled_branch745:
label(continue_ , && after_call746);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch744:
apply_primitive_procedure(val , proc , argl);
after_call746:
null(argl);
cons(argl , val ,  argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "length") , env);
lookup_variable_value(val , symbol (tmp , "vars") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch741;
};
compiled_branch742:
label(continue_ , && after_call743);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch741:
apply_primitive_procedure(val , proc , argl);
after_call743:
restore(argl);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch747;
};
compiled_branch748:
label(continue_ , && after_call749);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch747:
apply_primitive_procedure(val , proc , argl);
after_call749:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch739;
};
true_branch738:
lookup_variable_value(proc , symbol (tmp , "cons") , env);
save(continue_);
save(proc);
lookup_variable_value(val , symbol (tmp , "base-env") , env);
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "make-frame") , env);
lookup_variable_value(val , symbol (tmp , "vals") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "vars") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch750;
};
compiled_branch751:
label(continue_ , && after_call752);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch750:
apply_primitive_procedure(val , proc , argl);
after_call752:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch753;
};
compiled_branch754:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch753:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call755:
false_branch739:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "<") , env);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "length") , env);
lookup_variable_value(val , symbol (tmp , "vals") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch762;
};
compiled_branch763:
label(continue_ , && after_call764);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch762:
apply_primitive_procedure(val , proc , argl);
after_call764:
null(argl);
cons(argl , val ,  argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "length") , env);
lookup_variable_value(val , symbol (tmp , "vars") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch759;
};
compiled_branch760:
label(continue_ , && after_call761);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch759:
apply_primitive_procedure(val , proc , argl);
after_call761:
restore(argl);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch765;
};
compiled_branch766:
label(continue_ , && after_call767);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch765:
apply_primitive_procedure(val , proc , argl);
after_call767:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch757;
};
true_branch756:
lookup_variable_value(proc , symbol (tmp , "error") , env);
lookup_variable_value(val , symbol (tmp , "vals") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "vars") , env);
cons(argl , val , argl);
str(val , "Too many arguments supplied");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch768;
};
compiled_branch769:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch768:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call770:
false_branch757:
lookup_variable_value(proc , symbol (tmp , "error") , env);
lookup_variable_value(val , symbol (tmp , "vals") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "vars") , env);
cons(argl , val , argl);
str(val , "Too few arguments supplied");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch771;
};
compiled_branch772:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch771:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call773:
after_if758:
after_if740:
after_lambda737:
define_variable(symbol (tmp ,  "extend-environment") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry774) , env);
goto after_lambda775;
entry774:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  2 , "var" , "env" )) , argl , env);
make_compiled_procedure(val , label (tmp , && entry776) , env);
goto after_lambda777;
entry776:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "env" )) , argl , env);
make_compiled_procedure(val , label (tmp , && entry778) , env);
goto after_lambda779;
entry778:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  2 , "vars" , "vals" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "null?") , env);
lookup_variable_value(val , symbol (tmp , "vars") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch783;
};
compiled_branch784:
label(continue_ , && after_call785);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch783:
apply_primitive_procedure(val , proc , argl);
after_call785:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch781;
};
true_branch780:
lookup_variable_value(proc , symbol (tmp , "env-loop") , env);
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "enclosing-environment") , env);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch786;
};
compiled_branch787:
label(continue_ , && after_call788);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch786:
apply_primitive_procedure(val , proc , argl);
after_call788:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch789;
};
compiled_branch790:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch789:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call791:
false_branch781:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "eq?") , env);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "car") , env);
lookup_variable_value(val , symbol (tmp , "vars") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch795;
};
compiled_branch796:
label(continue_ , && after_call797);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch795:
apply_primitive_procedure(val , proc , argl);
after_call797:
null(argl);
cons(argl , val ,  argl);
restore(env);
lookup_variable_value(val , symbol (tmp , "var") , env);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch798;
};
compiled_branch799:
label(continue_ , && after_call800);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch798:
apply_primitive_procedure(val , proc , argl);
after_call800:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch793;
};
true_branch792:
lookup_variable_value(proc , symbol (tmp , "car") , env);
lookup_variable_value(val , symbol (tmp , "vals") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch801;
};
compiled_branch802:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch801:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call803:
false_branch793:
lookup_variable_value(proc , symbol (tmp , "scan") , env);
save(continue_);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "vals") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch807;
};
compiled_branch808:
label(continue_ , && after_call809);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch807:
apply_primitive_procedure(val , proc , argl);
after_call809:
null(argl);
cons(argl , val ,  argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "vars") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch804;
};
compiled_branch805:
label(continue_ , && after_call806);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch804:
apply_primitive_procedure(val , proc , argl);
after_call806:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch810;
};
compiled_branch811:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch810:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call812:
after_if794:
after_if782:
after_lambda779:
define_variable(symbol (tmp ,  "scan") , val , env);
symbol(val , "ok");
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "eq?") , env);
lookup_variable_value(val , symbol (tmp , "the-empty-environment") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "env") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch816;
};
compiled_branch817:
label(continue_ , && after_call818);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch816:
apply_primitive_procedure(val , proc , argl);
after_call818:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch814;
};
true_branch813:
lookup_variable_value(proc , symbol (tmp , "error") , env);
lookup_variable_value(val , symbol (tmp , "var") , env);
null(argl);
cons(argl , val ,  argl);
str(val , "Unbound variable");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch819;
};
compiled_branch820:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch819:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call821:
false_branch814:
make_compiled_procedure(proc , label (tmp , && entry822) , env);
goto after_lambda823;
entry822:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "frame" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "scan") , env);
save(continue_);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "frame-values") , env);
lookup_variable_value(val , symbol (tmp , "frame") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch827;
};
compiled_branch828:
label(continue_ , && after_call829);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch827:
apply_primitive_procedure(val , proc , argl);
after_call829:
null(argl);
cons(argl , val ,  argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "frame-variables") , env);
lookup_variable_value(val , symbol (tmp , "frame") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch824;
};
compiled_branch825:
label(continue_ , && after_call826);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch824:
apply_primitive_procedure(val , proc , argl);
after_call826:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch830;
};
compiled_branch831:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch830:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call832:
after_lambda823:
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "first-frame") , env);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch833;
};
compiled_branch834:
label(continue_ , && after_call835);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch833:
apply_primitive_procedure(val , proc , argl);
after_call835:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch836;
};
compiled_branch837:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch836:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call838:
after_if815:
after_lambda777:
define_variable(symbol (tmp ,  "env-loop") , val , env);
symbol(val , "ok");
lookup_variable_value(proc , symbol (tmp , "env-loop") , env);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch839;
};
compiled_branch840:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch839:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call841:
after_lambda775:
define_variable(symbol (tmp ,  "lookup-variable-value") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry842) , env);
goto after_lambda843;
entry842:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  3 , "var" , "val" , "env" )) , argl , env);
make_compiled_procedure(val , label (tmp , && entry844) , env);
goto after_lambda845;
entry844:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "env" )) , argl , env);
make_compiled_procedure(val , label (tmp , && entry846) , env);
goto after_lambda847;
entry846:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  2 , "vars" , "vals" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "null?") , env);
lookup_variable_value(val , symbol (tmp , "vars") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch851;
};
compiled_branch852:
label(continue_ , && after_call853);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch851:
apply_primitive_procedure(val , proc , argl);
after_call853:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch849;
};
true_branch848:
lookup_variable_value(proc , symbol (tmp , "env-loop") , env);
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "enclosing-environment") , env);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch854;
};
compiled_branch855:
label(continue_ , && after_call856);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch854:
apply_primitive_procedure(val , proc , argl);
after_call856:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch857;
};
compiled_branch858:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch857:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call859:
false_branch849:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "eq?") , env);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "car") , env);
lookup_variable_value(val , symbol (tmp , "vars") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch863;
};
compiled_branch864:
label(continue_ , && after_call865);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch863:
apply_primitive_procedure(val , proc , argl);
after_call865:
null(argl);
cons(argl , val ,  argl);
restore(env);
lookup_variable_value(val , symbol (tmp , "var") , env);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch866;
};
compiled_branch867:
label(continue_ , && after_call868);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch866:
apply_primitive_procedure(val , proc , argl);
after_call868:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch861;
};
true_branch860:
lookup_variable_value(proc , symbol (tmp , "set-car!") , env);
lookup_variable_value(val , symbol (tmp , "val") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "vals") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch869;
};
compiled_branch870:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch869:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call871:
false_branch861:
lookup_variable_value(proc , symbol (tmp , "scan") , env);
save(continue_);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "vals") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch875;
};
compiled_branch876:
label(continue_ , && after_call877);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch875:
apply_primitive_procedure(val , proc , argl);
after_call877:
null(argl);
cons(argl , val ,  argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "vars") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch872;
};
compiled_branch873:
label(continue_ , && after_call874);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch872:
apply_primitive_procedure(val , proc , argl);
after_call874:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch878;
};
compiled_branch879:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch878:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call880:
after_if862:
after_if850:
after_lambda847:
define_variable(symbol (tmp ,  "scan") , val , env);
symbol(val , "ok");
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "eq?") , env);
lookup_variable_value(val , symbol (tmp , "the-empty-environment") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "env") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch884;
};
compiled_branch885:
label(continue_ , && after_call886);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch884:
apply_primitive_procedure(val , proc , argl);
after_call886:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch882;
};
true_branch881:
lookup_variable_value(proc , symbol (tmp , "error") , env);
lookup_variable_value(val , symbol (tmp , "var") , env);
null(argl);
cons(argl , val ,  argl);
str(val , "Unbound variable -- SET!");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch887;
};
compiled_branch888:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch887:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call889:
false_branch882:
make_compiled_procedure(proc , label (tmp , && entry890) , env);
goto after_lambda891;
entry890:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "frame" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "scan") , env);
save(continue_);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "frame-values") , env);
lookup_variable_value(val , symbol (tmp , "frame") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch895;
};
compiled_branch896:
label(continue_ , && after_call897);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch895:
apply_primitive_procedure(val , proc , argl);
after_call897:
null(argl);
cons(argl , val ,  argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "frame-variables") , env);
lookup_variable_value(val , symbol (tmp , "frame") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch892;
};
compiled_branch893:
label(continue_ , && after_call894);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch892:
apply_primitive_procedure(val , proc , argl);
after_call894:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch898;
};
compiled_branch899:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch898:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call900:
after_lambda891:
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "first-frame") , env);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch901;
};
compiled_branch902:
label(continue_ , && after_call903);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch901:
apply_primitive_procedure(val , proc , argl);
after_call903:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch904;
};
compiled_branch905:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch904:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call906:
after_if883:
after_lambda845:
define_variable(symbol (tmp ,  "env-loop") , val , env);
symbol(val , "ok");
lookup_variable_value(proc , symbol (tmp , "env-loop") , env);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch907;
};
compiled_branch908:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch907:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call909:
after_lambda843:
define_variable(symbol (tmp ,  "set-variable-value!") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry910) , env);
goto after_lambda911;
entry910:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  3 , "var" , "val" , "env" )) , argl , env);
make_compiled_procedure(proc , label (tmp , && entry912) , env);
goto after_lambda913;
entry912:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "frame" )) , argl , env);
make_compiled_procedure(val , label (tmp , && entry914) , env);
goto after_lambda915;
entry914:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  2 , "vars" , "vals" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "null?") , env);
lookup_variable_value(val , symbol (tmp , "vars") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch919;
};
compiled_branch920:
label(continue_ , && after_call921);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch919:
apply_primitive_procedure(val , proc , argl);
after_call921:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch917;
};
true_branch916:
lookup_variable_value(proc , symbol (tmp , "add-binding-to-frame!") , env);
lookup_variable_value(val , symbol (tmp , "frame") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "val") , env);
cons(argl , val , argl);
lookup_variable_value(val , symbol (tmp , "var") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch922;
};
compiled_branch923:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch922:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call924:
false_branch917:
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "eq?") , env);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "car") , env);
lookup_variable_value(val , symbol (tmp , "vars") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch928;
};
compiled_branch929:
label(continue_ , && after_call930);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch928:
apply_primitive_procedure(val , proc , argl);
after_call930:
null(argl);
cons(argl , val ,  argl);
restore(env);
lookup_variable_value(val , symbol (tmp , "var") , env);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch931;
};
compiled_branch932:
label(continue_ , && after_call933);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch931:
apply_primitive_procedure(val , proc , argl);
after_call933:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch926;
};
true_branch925:
lookup_variable_value(proc , symbol (tmp , "set-car!") , env);
lookup_variable_value(val , symbol (tmp , "val") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "vals") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch934;
};
compiled_branch935:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch934:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call936:
false_branch926:
lookup_variable_value(proc , symbol (tmp , "scan") , env);
save(continue_);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "vals") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch940;
};
compiled_branch941:
label(continue_ , && after_call942);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch940:
apply_primitive_procedure(val , proc , argl);
after_call942:
null(argl);
cons(argl , val ,  argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "vars") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch937;
};
compiled_branch938:
label(continue_ , && after_call939);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch937:
apply_primitive_procedure(val , proc , argl);
after_call939:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch943;
};
compiled_branch944:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch943:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call945:
after_if927:
after_if918:
after_lambda915:
define_variable(symbol (tmp ,  "scan") , val , env);
symbol(val , "ok");
lookup_variable_value(proc , symbol (tmp , "scan") , env);
save(continue_);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "frame-values") , env);
lookup_variable_value(val , symbol (tmp , "frame") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch949;
};
compiled_branch950:
label(continue_ , && after_call951);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch949:
apply_primitive_procedure(val , proc , argl);
after_call951:
null(argl);
cons(argl , val ,  argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "frame-variables") , env);
lookup_variable_value(val , symbol (tmp , "frame") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch946;
};
compiled_branch947:
label(continue_ , && after_call948);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch946:
apply_primitive_procedure(val , proc , argl);
after_call948:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch952;
};
compiled_branch953:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch952:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call954:
after_lambda913:
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "first-frame") , env);
lookup_variable_value(val , symbol (tmp , "env") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch955;
};
compiled_branch956:
label(continue_ , && after_call957);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch955:
apply_primitive_procedure(val , proc , argl);
after_call957:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch958;
};
compiled_branch959:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch958:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call960:
after_lambda911:
define_variable(symbol (tmp ,  "define-variable!") , val , env);
symbol(val , "ok");
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "list") , env);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "<=") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "<=");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1054;
};
compiled_branch1055:
label(continue_ , && after_call1056);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1054:
apply_primitive_procedure(val , proc , argl);
after_call1056:
null(argl);
cons(argl , val ,  argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "<") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "<");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1051;
};
compiled_branch1052:
label(continue_ , && after_call1053);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1051:
apply_primitive_procedure(val , proc , argl);
after_call1053:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , ">=") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , ">=");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1048;
};
compiled_branch1049:
label(continue_ , && after_call1050);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1048:
apply_primitive_procedure(val , proc , argl);
after_call1050:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , ">") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , ">");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1045;
};
compiled_branch1046:
label(continue_ , && after_call1047);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1045:
apply_primitive_procedure(val , proc , argl);
after_call1047:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "=") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "=");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1042;
};
compiled_branch1043:
label(continue_ , && after_call1044);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1042:
apply_primitive_procedure(val , proc , argl);
after_call1044:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "sqrt") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "sqrt");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1039;
};
compiled_branch1040:
label(continue_ , && after_call1041);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1039:
apply_primitive_procedure(val , proc , argl);
after_call1041:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "max") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "max");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1036;
};
compiled_branch1037:
label(continue_ , && after_call1038);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1036:
apply_primitive_procedure(val , proc , argl);
after_call1038:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "min") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "min");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1033;
};
compiled_branch1034:
label(continue_ , && after_call1035);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1033:
apply_primitive_procedure(val , proc , argl);
after_call1035:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "remainder") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "remainder");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1030;
};
compiled_branch1031:
label(continue_ , && after_call1032);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1030:
apply_primitive_procedure(val , proc , argl);
after_call1032:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "/") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "/");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1027;
};
compiled_branch1028:
label(continue_ , && after_call1029);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1027:
apply_primitive_procedure(val , proc , argl);
after_call1029:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "*") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "*");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1024;
};
compiled_branch1025:
label(continue_ , && after_call1026);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1024:
apply_primitive_procedure(val , proc , argl);
after_call1026:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "-") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "-");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1021;
};
compiled_branch1022:
label(continue_ , && after_call1023);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1021:
apply_primitive_procedure(val , proc , argl);
after_call1023:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "+") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "+");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1018;
};
compiled_branch1019:
label(continue_ , && after_call1020);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1018:
apply_primitive_procedure(val , proc , argl);
after_call1020:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "error") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "error");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1015;
};
compiled_branch1016:
label(continue_ , && after_call1017);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1015:
apply_primitive_procedure(val , proc , argl);
after_call1017:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "read") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "read");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1012;
};
compiled_branch1013:
label(continue_ , && after_call1014);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1012:
apply_primitive_procedure(val , proc , argl);
after_call1014:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "newline") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "newline");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1009;
};
compiled_branch1010:
label(continue_ , && after_call1011);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1009:
apply_primitive_procedure(val , proc , argl);
after_call1011:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "displayln") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "displayln");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1006;
};
compiled_branch1007:
label(continue_ , && after_call1008);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1006:
apply_primitive_procedure(val , proc , argl);
after_call1008:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "display") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "display");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1003;
};
compiled_branch1004:
label(continue_ , && after_call1005);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1003:
apply_primitive_procedure(val , proc , argl);
after_call1005:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "pair?") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "pair?");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1000;
};
compiled_branch1001:
label(continue_ , && after_call1002);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1000:
apply_primitive_procedure(val , proc , argl);
after_call1002:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "symbol?") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "symbol?");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch997;
};
compiled_branch998:
label(continue_ , && after_call999);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch997:
apply_primitive_procedure(val , proc , argl);
after_call999:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "number?") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "number?");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch994;
};
compiled_branch995:
label(continue_ , && after_call996);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch994:
apply_primitive_procedure(val , proc , argl);
after_call996:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "string?") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "string?");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch991;
};
compiled_branch992:
label(continue_ , && after_call993);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch991:
apply_primitive_procedure(val , proc , argl);
after_call993:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "boolean?") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "boolean?");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch988;
};
compiled_branch989:
label(continue_ , && after_call990);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch988:
apply_primitive_procedure(val , proc , argl);
after_call990:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "eq?") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "eq?");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch985;
};
compiled_branch986:
label(continue_ , && after_call987);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch985:
apply_primitive_procedure(val , proc , argl);
after_call987:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "null?") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "null?");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch982;
};
compiled_branch983:
label(continue_ , && after_call984);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch982:
apply_primitive_procedure(val , proc , argl);
after_call984:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "set-cdr!") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "set-cdr!");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch979;
};
compiled_branch980:
label(continue_ , && after_call981);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch979:
apply_primitive_procedure(val , proc , argl);
after_call981:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "set-car!") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "set-car!");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch976;
};
compiled_branch977:
label(continue_ , && after_call978);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch976:
apply_primitive_procedure(val , proc , argl);
after_call978:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "cdr") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "cdr");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch973;
};
compiled_branch974:
label(continue_ , && after_call975);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch973:
apply_primitive_procedure(val , proc , argl);
after_call975:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "car") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "car");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch970;
};
compiled_branch971:
label(continue_ , && after_call972);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch970:
apply_primitive_procedure(val , proc , argl);
after_call972:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "cons") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "cons");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch967;
};
compiled_branch968:
label(continue_ , && after_call969);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch967:
apply_primitive_procedure(val , proc , argl);
after_call969:
restore(argl);
cons(argl , val , argl);
restore(env);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "append") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "append");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch964;
};
compiled_branch965:
label(continue_ , && after_call966);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch964:
apply_primitive_procedure(val , proc , argl);
after_call966:
restore(argl);
cons(argl , val , argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "list") , env);
lookup_variable_value(val , symbol (tmp , "list") , env);
null(argl);
cons(argl , val ,  argl);
symbol(val , "list");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch961;
};
compiled_branch962:
label(continue_ , && after_call963);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch961:
apply_primitive_procedure(val , proc , argl);
after_call963:
restore(argl);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch1057;
};
compiled_branch1058:
label(continue_ , && after_call1059);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1057:
apply_primitive_procedure(val , proc , argl);
after_call1059:
restore(env);
define_variable(symbol (tmp ,  "primitive-procedures") , val , env);
symbol(val , "ok");
restore(continue_);
make_compiled_procedure(val , label (tmp , && entry1060) , env);
goto after_lambda1061;
entry1060:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  0 )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "map") , env);
lookup_variable_value(val , symbol (tmp , "primitive-procedures") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "car") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1062;
};
compiled_branch1063:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1062:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1064:
after_lambda1061:
define_variable(symbol (tmp ,  "primitive-procedure-names") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1065) , env);
goto after_lambda1066;
entry1065:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  0 )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "map") , env);
lookup_variable_value(val , symbol (tmp , "primitive-procedures") , env);
null(argl);
cons(argl , val ,  argl);
make_compiled_procedure(val , label (tmp , && entry1067) , env);
goto after_lambda1068;
entry1067:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "proc" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "list") , env);
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cadr") , env);
lookup_variable_value(val , symbol (tmp , "proc") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1069;
};
compiled_branch1070:
label(continue_ , && after_call1071);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1069:
apply_primitive_procedure(val , proc , argl);
after_call1071:
null(argl);
cons(argl , val ,  argl);
symbol(val , "primitive");
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch1072;
};
compiled_branch1073:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1072:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1074:
after_lambda1068:
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1075;
};
compiled_branch1076:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1075:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1077:
after_lambda1066:
define_variable(symbol (tmp ,  "primitive-procedure-objects") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1078) , env);
goto after_lambda1079;
entry1078:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  0 )) , argl , env);
make_compiled_procedure(proc , label (tmp , && entry1080) , env);
goto after_lambda1081;
entry1080:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "initial-env" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "define-variable!") , env);
lookup_variable_value(val , symbol (tmp , "initial-env") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "true") , env);
cons(argl , val , argl);
symbol(val , "true");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1082;
};
compiled_branch1083:
label(continue_ , && after_call1084);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1082:
apply_primitive_procedure(val , proc , argl);
after_call1084:
restore(env);
restore(continue_);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "define-variable!") , env);
lookup_variable_value(val , symbol (tmp , "initial-env") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "false") , env);
cons(argl , val , argl);
symbol(val , "false");
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1085;
};
compiled_branch1086:
label(continue_ , && after_call1087);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1085:
apply_primitive_procedure(val , proc , argl);
after_call1087:
restore(env);
restore(continue_);
lookup_variable_value(val , symbol (tmp , "initial-env") , env);
goto*label_get(continue_);
after_lambda1081:
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "extend-environment") , env);
save(proc);
lookup_variable_value(val , symbol (tmp , "the-empty-environment") , env);
null(argl);
cons(argl , val ,  argl);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "primitive-procedure-objects") , env);
null(argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1091;
};
compiled_branch1092:
label(continue_ , && after_call1093);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1091:
apply_primitive_procedure(val , proc , argl);
after_call1093:
restore(argl);
cons(argl , val , argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "primitive-procedure-names") , env);
null(argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1088;
};
compiled_branch1089:
label(continue_ , && after_call1090);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1088:
apply_primitive_procedure(val , proc , argl);
after_call1090:
restore(argl);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch1094;
};
compiled_branch1095:
label(continue_ , && after_call1096);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1094:
apply_primitive_procedure(val , proc , argl);
after_call1096:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch1097;
};
compiled_branch1098:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1097:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1099:
after_lambda1079:
define_variable(symbol (tmp ,  "setup-environment") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1100) , env);
goto after_lambda1101;
entry1100:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "proc" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "tagged-list?") , env);
symbol(val , "primitive");
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "proc") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1102;
};
compiled_branch1103:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1102:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1104:
after_lambda1101:
define_variable(symbol (tmp ,  "primitive-procedure?") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1105) , env);
goto after_lambda1106;
entry1105:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "proc" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cadr") , env);
lookup_variable_value(val , symbol (tmp , "proc") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1107;
};
compiled_branch1108:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1107:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1109:
after_lambda1106:
define_variable(symbol (tmp ,  "primitive-implementation") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1110) , env);
goto after_lambda1111;
entry1110:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  2 , "proc" , "args" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "apply-in-underlying-scheme") , env);
save(continue_);
save(proc);
lookup_variable_value(val , symbol (tmp , "args") , env);
null(argl);
cons(argl , val ,  argl);
save(argl);
lookup_variable_value(proc , symbol (tmp , "primitive-implementation") , env);
lookup_variable_value(val , symbol (tmp , "proc") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1112;
};
compiled_branch1113:
label(continue_ , && after_call1114);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1112:
apply_primitive_procedure(val , proc , argl);
after_call1114:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch1115;
};
compiled_branch1116:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1115:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1117:
after_lambda1111:
define_variable(symbol (tmp ,  "apply-primitive-procedure") , val , env);
symbol(val , "ok");
str(val , "M-Eval input:");
define_variable(symbol (tmp ,  "input-prompt") , val , env);
symbol(val , "ok");
str(val , "M-Eval value:");
define_variable(symbol (tmp ,  "output-prompt") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1118) , env);
goto after_lambda1119;
entry1118:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  0 )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "prompt-for-input") , env);
lookup_variable_value(val , symbol (tmp , "input-prompt") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1120;
};
compiled_branch1121:
label(continue_ , && after_call1122);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1120:
apply_primitive_procedure(val , proc , argl);
after_call1122:
restore(env);
restore(continue_);
save(continue_);
save(env);
make_compiled_procedure(proc , label (tmp , && entry1123) , env);
goto after_lambda1124;
entry1123:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "input" )) , argl , env);
make_compiled_procedure(proc , label (tmp , && entry1125) , env);
goto after_lambda1126;
entry1125:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "output" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "announce-output") , env);
lookup_variable_value(val , symbol (tmp , "output-prompt") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1127;
};
compiled_branch1128:
label(continue_ , && after_call1129);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1127:
apply_primitive_procedure(val , proc , argl);
after_call1129:
restore(env);
restore(continue_);
lookup_variable_value(proc , symbol (tmp , "user-print") , env);
lookup_variable_value(val , symbol (tmp , "output") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1130;
};
compiled_branch1131:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1130:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1132:
after_lambda1126:
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "eval") , env);
lookup_variable_value(val , symbol (tmp , "the-global-environment") , env);
null(argl);
cons(argl , val ,  argl);
lookup_variable_value(val , symbol (tmp , "input") , env);
cons(argl , val , argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1133;
};
compiled_branch1134:
label(continue_ , && after_call1135);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1133:
apply_primitive_procedure(val , proc , argl);
after_call1135:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch1136;
};
compiled_branch1137:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1136:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1138:
after_lambda1124:
save(proc);
lookup_variable_value(proc , symbol (tmp , "read") , env);
null(argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1139;
};
compiled_branch1140:
label(continue_ , && after_call1141);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1139:
apply_primitive_procedure(val , proc , argl);
after_call1141:
null(argl);
cons(argl , val ,  argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch1142;
};
compiled_branch1143:
label(continue_ , && after_call1144);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1142:
apply_primitive_procedure(val , proc , argl);
after_call1144:
restore(env);
restore(continue_);
lookup_variable_value(proc , symbol (tmp , "driver-loop") , env);
null(argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1145;
};
compiled_branch1146:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1145:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1147:
after_lambda1119:
define_variable(symbol (tmp ,  "driver-loop") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1148) , env);
goto after_lambda1149;
entry1148:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "string" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "newline") , env);
null(argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1150;
};
compiled_branch1151:
label(continue_ , && after_call1152);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1150:
apply_primitive_procedure(val , proc , argl);
after_call1152:
restore(env);
restore(continue_);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "newline") , env);
null(argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1153;
};
compiled_branch1154:
label(continue_ , && after_call1155);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1153:
apply_primitive_procedure(val , proc , argl);
after_call1155:
restore(env);
restore(continue_);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "display") , env);
lookup_variable_value(val , symbol (tmp , "string") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1156;
};
compiled_branch1157:
label(continue_ , && after_call1158);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1156:
apply_primitive_procedure(val , proc , argl);
after_call1158:
restore(env);
restore(continue_);
lookup_variable_value(proc , symbol (tmp , "newline") , env);
null(argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1159;
};
compiled_branch1160:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1159:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1161:
after_lambda1149:
define_variable(symbol (tmp ,  "prompt-for-input") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1162) , env);
goto after_lambda1163;
entry1162:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "string" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "newline") , env);
null(argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1164;
};
compiled_branch1165:
label(continue_ , && after_call1166);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1164:
apply_primitive_procedure(val , proc , argl);
after_call1166:
restore(env);
restore(continue_);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "display") , env);
lookup_variable_value(val , symbol (tmp , "string") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1167;
};
compiled_branch1168:
label(continue_ , && after_call1169);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1167:
apply_primitive_procedure(val , proc , argl);
after_call1169:
restore(env);
restore(continue_);
lookup_variable_value(proc , symbol (tmp , "newline") , env);
null(argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1170;
};
compiled_branch1171:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1170:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1172:
after_lambda1163:
define_variable(symbol (tmp ,  "announce-output") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1173) , env);
goto after_lambda1174;
entry1173:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "object" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "compound-procedure?") , env);
lookup_variable_value(val , symbol (tmp , "object") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1178;
};
compiled_branch1179:
label(continue_ , && after_call1180);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1178:
apply_primitive_procedure(val , proc , argl);
after_call1180:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch1176;
};
true_branch1175:
lookup_variable_value(proc , symbol (tmp , "display") , env);
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "list") , env);
save(proc);
symbol(val , "<procedure-env>");
null(argl);
cons(argl , val ,  argl);
save(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "procedure-body") , env);
lookup_variable_value(val , symbol (tmp , "object") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1184;
};
compiled_branch1185:
label(continue_ , && after_call1186);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1184:
apply_primitive_procedure(val , proc , argl);
after_call1186:
restore(argl);
cons(argl , val , argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "procedure-parameters") , env);
lookup_variable_value(val , symbol (tmp , "object") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1181;
};
compiled_branch1182:
label(continue_ , && after_call1183);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1181:
apply_primitive_procedure(val , proc , argl);
after_call1183:
restore(argl);
cons(argl , val , argl);
symbol(val , "compound-procedure");
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch1187;
};
compiled_branch1188:
label(continue_ , && after_call1189);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1187:
apply_primitive_procedure(val , proc , argl);
after_call1189:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch1190;
};
compiled_branch1191:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1190:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1192:
false_branch1176:
lookup_variable_value(proc , symbol (tmp , "display") , env);
lookup_variable_value(val , symbol (tmp , "object") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1193;
};
compiled_branch1194:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1193:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1195:
after_if1177:
after_lambda1174:
define_variable(symbol (tmp ,  "user-print") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1196) , env);
goto after_lambda1197;
entry1196:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  2 , "op" , "sequence" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "null?") , env);
lookup_variable_value(val , symbol (tmp , "sequence") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1201;
};
compiled_branch1202:
label(continue_ , && after_call1203);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1201:
apply_primitive_procedure(val , proc , argl);
after_call1203:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch1199;
};
true_branch1198:
null(val);
goto*label_get(continue_);
false_branch1199:
lookup_variable_value(proc , symbol (tmp , "cons") , env);
save(continue_);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "map") , env);
save(proc);
save(env);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "sequence") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1210;
};
compiled_branch1211:
label(continue_ , && after_call1212);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1210:
apply_primitive_procedure(val , proc , argl);
after_call1212:
null(argl);
cons(argl , val ,  argl);
restore(env);
lookup_variable_value(val , symbol (tmp , "op") , env);
cons(argl , val , argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch1213;
};
compiled_branch1214:
label(continue_ , && after_call1215);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1213:
apply_primitive_procedure(val , proc , argl);
after_call1215:
null(argl);
cons(argl , val ,  argl);
restore(env);
save(argl);
lookup_variable_value(proc , symbol (tmp , "op") , env);
save(proc);
lookup_variable_value(proc , symbol (tmp , "car") , env);
lookup_variable_value(val , symbol (tmp , "sequence") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1204;
};
compiled_branch1205:
label(continue_ , && after_call1206);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1204:
apply_primitive_procedure(val , proc , argl);
after_call1206:
null(argl);
cons(argl , val ,  argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch1207;
};
compiled_branch1208:
label(continue_ , && after_call1209);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1207:
apply_primitive_procedure(val , proc , argl);
after_call1209:
restore(argl);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch1216;
};
compiled_branch1217:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1216:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1218:
after_if1200:
after_lambda1197:
define_variable(symbol (tmp ,  "map") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1219) , env);
goto after_lambda1220;
entry1219:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "lst" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "car") , env);
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "lst") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1221;
};
compiled_branch1222:
label(continue_ , && after_call1223);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1221:
apply_primitive_procedure(val , proc , argl);
after_call1223:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch1224;
};
compiled_branch1225:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1224:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1226:
after_lambda1220:
define_variable(symbol (tmp ,  "cadr") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1227) , env);
goto after_lambda1228;
entry1227:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "lst" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "lst") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1229;
};
compiled_branch1230:
label(continue_ , && after_call1231);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1229:
apply_primitive_procedure(val , proc , argl);
after_call1231:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch1232;
};
compiled_branch1233:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1232:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1234:
after_lambda1228:
define_variable(symbol (tmp ,  "cddr") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1235) , env);
goto after_lambda1236;
entry1235:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "lst" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "car") , env);
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "car") , env);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "lst") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1237;
};
compiled_branch1238:
label(continue_ , && after_call1239);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1237:
apply_primitive_procedure(val , proc , argl);
after_call1239:
null(argl);
cons(argl , val ,  argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch1240;
};
compiled_branch1241:
label(continue_ , && after_call1242);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1240:
apply_primitive_procedure(val , proc , argl);
after_call1242:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch1243;
};
compiled_branch1244:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1243:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1245:
after_lambda1236:
define_variable(symbol (tmp ,  "caadr") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1246) , env);
goto after_lambda1247;
entry1246:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "lst" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "car") , env);
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "lst") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1248;
};
compiled_branch1249:
label(continue_ , && after_call1250);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1248:
apply_primitive_procedure(val , proc , argl);
after_call1250:
null(argl);
cons(argl , val ,  argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch1251;
};
compiled_branch1252:
label(continue_ , && after_call1253);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1251:
apply_primitive_procedure(val , proc , argl);
after_call1253:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch1254;
};
compiled_branch1255:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1254:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1256:
after_lambda1247:
define_variable(symbol (tmp ,  "caddr") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1257) , env);
goto after_lambda1258;
entry1257:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "lst" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "car") , env);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "lst") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1259;
};
compiled_branch1260:
label(continue_ , && after_call1261);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1259:
apply_primitive_procedure(val , proc , argl);
after_call1261:
null(argl);
cons(argl , val ,  argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch1262;
};
compiled_branch1263:
label(continue_ , && after_call1264);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1262:
apply_primitive_procedure(val , proc , argl);
after_call1264:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch1265;
};
compiled_branch1266:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1265:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1267:
after_lambda1258:
define_variable(symbol (tmp ,  "cdadr") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1268) , env);
goto after_lambda1269;
entry1268:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "lst" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "lst") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1270;
};
compiled_branch1271:
label(continue_ , && after_call1272);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1270:
apply_primitive_procedure(val , proc , argl);
after_call1272:
null(argl);
cons(argl , val ,  argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch1273;
};
compiled_branch1274:
label(continue_ , && after_call1275);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1273:
apply_primitive_procedure(val , proc , argl);
after_call1275:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch1276;
};
compiled_branch1277:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1276:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1278:
after_lambda1269:
define_variable(symbol (tmp ,  "cdddr") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1279) , env);
goto after_lambda1280;
entry1279:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "lst" )) , argl , env);
lookup_variable_value(proc , symbol (tmp , "car") , env);
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "lst") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1281;
};
compiled_branch1282:
label(continue_ , && after_call1283);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1281:
apply_primitive_procedure(val , proc , argl);
after_call1283:
null(argl);
cons(argl , val ,  argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch1284;
};
compiled_branch1285:
label(continue_ , && after_call1286);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1284:
apply_primitive_procedure(val , proc , argl);
after_call1286:
null(argl);
cons(argl , val ,  argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch1287;
};
compiled_branch1288:
label(continue_ , && after_call1289);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1287:
apply_primitive_procedure(val , proc , argl);
after_call1289:
null(argl);
cons(argl , val ,  argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch1290;
};
compiled_branch1291:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1290:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1292:
after_lambda1280:
define_variable(symbol (tmp ,  "cadddr") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1293) , env);
goto after_lambda1294;
entry1293:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "x" )) , argl , env);
lookup_variable_value(val , symbol (tmp , "x") , env);
if (is_false (val)) {
goto false_branch1296;
};
true_branch1295:
lookup_variable_value(val , symbol (tmp , "false") , env);
goto*label_get(continue_);
false_branch1296:
lookup_variable_value(val , symbol (tmp , "true") , env);
goto*label_get(continue_);
after_if1297:
after_lambda1294:
define_variable(symbol (tmp ,  "not") , val , env);
symbol(val , "ok");
make_compiled_procedure(val , label (tmp , && entry1298) , env);
goto after_lambda1299;
entry1298:
compiled_procedure_env(env , proc);
extend_environment(env , (symbol_list(tmp ,  1 , "items" )) , argl , env);
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "null?") , env);
lookup_variable_value(val , symbol (tmp , "items") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1303;
};
compiled_branch1304:
label(continue_ , && after_call1305);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1303:
apply_primitive_procedure(val , proc , argl);
after_call1305:
restore(env);
restore(continue_);
if (is_false (val)) {
goto false_branch1301;
};
true_branch1300:
number(val , 0);
goto*label_get(continue_);
false_branch1301:
lookup_variable_value(proc , symbol (tmp , "+") , env);
save(continue_);
save(proc);
lookup_variable_value(proc , symbol (tmp , "length") , env);
save(proc);
lookup_variable_value(proc , symbol (tmp , "cdr") , env);
lookup_variable_value(val , symbol (tmp , "items") , env);
null(argl);
cons(argl , val ,  argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1306;
};
compiled_branch1307:
label(continue_ , && after_call1308);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1306:
apply_primitive_procedure(val , proc , argl);
after_call1308:
null(argl);
cons(argl , val ,  argl);
restore(proc);
if (is_primitive_procedure (proc)) {
goto primitive_branch1309;
};
compiled_branch1310:
label(continue_ , && after_call1311);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1309:
apply_primitive_procedure(val , proc , argl);
after_call1311:
null(argl);
cons(argl , val ,  argl);
number(val , 1);
cons(argl , val , argl);
restore(proc);
restore(continue_);
if (is_primitive_procedure (proc)) {
goto primitive_branch1312;
};
compiled_branch1313:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1312:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1314:
after_if1302:
after_lambda1299:
define_variable(symbol (tmp ,  "length") , val , env);
symbol(val , "ok");
save(continue_);
save(env);
lookup_variable_value(proc , symbol (tmp , "setup-environment") , env);
null(argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1315;
};
compiled_branch1316:
label(continue_ , && after_call1317);
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1315:
apply_primitive_procedure(val , proc , argl);
after_call1317:
restore(env);
define_variable(symbol (tmp ,  "the-global-environment") , val , env);
symbol(val , "ok");
restore(continue_);
lookup_variable_value(proc , symbol (tmp , "driver-loop") , env);
null(argl);
if (is_primitive_procedure (proc)) {
goto primitive_branch1318;
};
compiled_branch1319:
compiled_procedure_entry(val , proc);
goto*label_get(val);
primitive_branch1318:
apply_primitive_procedure(val , proc , argl);
goto*label_get(continue_);
after_call1320:
