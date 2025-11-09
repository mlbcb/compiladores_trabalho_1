typedef enum {OP_PLUS, OP_MINUS, OP_TIMES, OP_DIVISION, OP_REM, OP_MOD, OP_POWER, OP_EQUAL_TO, OP_DIFFERENT_THAN, 
              OP_GREATER_THAN, OP_LESS_THAN, OP_EQUAL_OR_GREATER, OP_EQUAL_OR_LESS, OP_AND, OP_OR, OP_XOR, OP_NOT
}BinOp;
//Observação: "NOT" evidentemente não é uma operação binária, mas preferiu-se incluir 
//em BinOp para simplificação

typedef enum { IDEXP, NUMEXP, FLOATEXP, BOOLEXP, OPEXP, PARENEXP
}ExpType;

struct _Exp {
    ExpType exp_t;     // tag
    union {            // alternatives
        char *ident;   // IDEXP
        int num;       // NUMEXP
        float fnum;    // FLOATEXP
        int booleano;      // BOOLEXP
        struct {   
            struct _Exp *left;
            BinOp op;
            struct _Exp *right;
        } opexp;        // OPEXP
        struct {
            struct _Exp *inside;
        } parenexp;      //PARENEXP
    } fields;
};
typedef struct _Exp *Exp;


typedef enum { ASSIGNSTM, COMPOUNDSTM, IFSTM, WHILESTM, PROCEDSTM 
}StmType;

struct _Stm {
    StmType stm_t;     // tag
    union {            // alternatives
        struct {
            char *ident;
            Exp exp;
        } assign;        // ASSIGNSTM
        struct {
            struct _Stm *fst;
            struct _Stm *snd;
        } compound;      // COMPOUNDSTM
        struct {
            Exp cond;
            struct _Stm *then_child;
            struct _Stm *else_child;
        }ifstm;         //IFSTM
        struct {
            Exp cond;
            struct _Stm *child;
        } whilestm;      //WHILESTM
        struct {
            struct _Stm *stmt;
        } procedstm;      //PROCEDSTM
    } fields;
};
typedef struct _Stm *Stm;

extern Stm root;

extern Stm mk_compound(Stm, Stm);
extern Stm mk_assign(char *, Exp);
extern Stm mk_if(Exp, Stm, Stm);
extern Stm mk_while(Exp, Stm);
extern Stm mk_proced(Stm);

extern Exp mk_opexp(Exp, BinOp, Exp);
extern Exp mk_numexp(int);
extern Exp mk_idexp(char *);
extern Exp mk_boolexp(int);
extern Exp mk_floatexp(float);
extern Exp mk_parenexp(Exp);

extern void print_exp(Exp);
extern void print_stm(Stm);
