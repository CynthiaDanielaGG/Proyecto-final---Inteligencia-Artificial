:-use_module(library(pce)).
:-use_module(library(pce_style_item)).

main:-
	new(Menu, dialog('Sistema experto de un Test Vocacional ITCh',size(500,500))),
	new(L, label(nombre,'Bienvenido al test vocacional')),

	new(@texto, label(nombre,'segun sus datos de cualidades, aptitudes y gustos, obtendras su resultado:')),
	new(@resp1, label(nombre,'')),

	new(Salir, button('Salir', and(message(Menu,destroy),message(Menu,free)))),
	new(@boton, button('Iniciar su Test Vocacional Itch',message(@prolog, botones))),
%%	tipo de letra
	send(L,font,font(times,bold,40)),
	send(@texto, font, font(arial,arial,20)),
	send(@resp1, font, font(times,bold,20)),
	send(Salir, font, font(arial,arial,15)),
	send(@boton, font, font(arial,arial,15)),

	send(Menu, append(L)),new(@btncarrera,button('¿Desea iniciar?')),
	send(Menu, display,L,point(125,20)),
	send(Menu, display,@boton,point(100,150)),
	send(Menu, display,@texto,point(20,100)),
	send(Menu, display,Salir,point(20,400)),
	send(Menu, display,@resp1,point(20,130)),
	send(Menu, open_centered).

%%      Carreras ITCH

        carreras(civil):- civil,!.
        carreras(sistemas):- sistemas,!.
        carreras(informatica):- informatica,!.
        carreras(gestion):- gestion,!.
        carreras(contador):- contador,!.
        carreras('Sin resultado').

%%	Preguntas especificas

civil :- es_civil,
	pregunta('¿Te gusta el diseño de edificios'),
	pregunta('¿Te gustaria tener clases de campo(fuera del aula)'),
	pregunta('¿Eres habil para las matematicas?'),
	pregunta('¿Te gusta la construccion de edificios?'),
	pregunta('¿Te gustaría trabajar en obras sanitarias?'),
	pregunta('¿Eres habil para la fisica?'),
	pregunta('¿Te gustaria trabajar en obras civiles?').
sistemas :- es_sistemas,
	pregunta('¿Te gusta el desarrollo de aplicaciones?'),
	pregunta('¿Tienes la habilidad para analizar un problema?'),
	pregunta('¿Eres habil para las matematicas?'),
	pregunta('¿Te gustaria trabajar en un laboratorio de computo?'),
	pregunta('¿Te gustaria administrar bases de datos?'),
	pregunta('¿Te gustaria conocer sobre las redes de computadoras?'),
	pregunta('¿Tienes habilidades para lo circuitos electronicos?').
informatica :- es_informatica,
	pregunta('¿Te gustaria administrar sistemas informaticos?'),
	pregunta('¿Realizar auditorias en centros de computo?'),
	pregunta('¿Tienes habilidad por las matematicas?'),
	pregunta('¿Te gustaria conocer mas sobre la administracion de sistemas operativos?'),
	pregunta('¿Te gustaria conocer sobre la administracion de archivos?'),
	pregunta('¿Te gustaria administrar redes de comunicacion?'),
	pregunta('¿Tienes habilidad para dar mantenimiento preventivo y correctivo a las computadoras?').
gestion :- es_gestion,
	pregunta('¿Te gustaria establecer programas para el fortalecimiento de la
	seguridad e higiene en las organizaciones?'),
	pregunta('¿Te gustaria realizar estrategias para la mejora de una empresa?'),
	pregunta('¿Tienes habilidades basicas para matematicas?'),
	pregunta('¿Te gustaria Aplicar métodos cuantitativos y cualitativos para
	el análisis e interpretación de datos
	y modelado de sistemas, en los procesos organizacionales para la mejora
	continua, atendiendo estándares de calidad
	mundial?'),
	pregunta('¿Te gustaria utilizar las nuevas tecnologías de información en
	la organización, para optimizar los procesos
	de comunicación y eficientar la toma de decisiones?'),
	pregunta('¿Te gustaria interpretar y aplicar normas legales que incidan en
	la creación y desarrollo de las organizaciones?'),
	pregunta('¿Te gustaria gestionar sistemas integrales de calidad, ejerciendo
	un liderazgo efectivo y un compromiso
	ético, aplicando las herramientas básicas de la ingeniería?').
contador :- es_contador,
	pregunta('¿Te gustaria diseñar, implantar, controlar, evaluar, asesorar e
	innovar sistemas de información financiera,
	administrativa, fiscal y de auditoría en entidades económicas?'),
	pregunta('¿Te gustaria analizar y generar información financiera con apego
	a las Normas de Información Financiera,
	nacionales e internacionales, para la toma de decisiones?'),
	pregunta('¿Te gustaria auditar sistemas financieros, fiscales y administrativos
	de las entidades económicas con apego
	a las Normas y Procedimientos de Auditoria y Normas para Atestiguar?'),
	pregunta('¿Te gustaria aplicar el marco legal pertinente a las características
	y necesidades de la entidad económica
	dentro del campo profesional?'),
	pregunta('¿Te gustaria administrar estratégicamente los recursos de las entidades
	económicas con visión emprendedora y
	competitiva?'),
	pregunta('¿Te gustaria utilizar las Tecnologías de Información y Comunicación
	para eficientar los procesos y la toma de
	decisiones.?'),
	pregunta('¿Te gustaria aplicar métodos de análisis de información financiera
	para determinar las mejores alternativas de
	inversión y financiamiento ?').

%%desconocido :- no_exite_carrera.

es_civil :- pregunta('¿Tienes habilidad por el diseño de obras civiles?'),!.
es_sistemas :- pregunta('¿Tienes habilidades por el desarrollo de software?'),!.
es_informatica :- pregunta('¿Tienes habilidades para el hadware de computadoras?'),!.
es_gestion :- pregunta('¿Tienes habilidades de lider?'),!.
es_contador :- pregunta('¿Tienes habilidades para gestionar recursos financieros'),!.

:-dynamic si/1,no/1.
preguntar(Problema):- new(Di,dialog('Test Vocacional')),
	new(L2,label(texto,'Responde las siguientes preguntas')),
	new(La,label(prob,Problema)),
	new(B1,button(si, and(message(Di,return,si)))),
	new(B2,button(no,and(message(Di,return,no)))),
	        send(Di,append(L2)),
		send(Di,append(La)),
		send(Di,append(B1)),
		send(Di,append(B2)),
		     send(Di,default_button,si),
		     send(Di,open_centered),get(Di,confirm,Answer),
		     write(Answer),send(Di,destroy),
		     ((Answer== si)->assert(si(Problema));
		     assert(no(Problema)),fail).
pregunta(S):- (si(S)->true; (no(S)->fail; preguntar(S))).
limpiar:-retract(si(_)),fail.
limpiar:-retract(no(_)),fail.
limpiar.

botones :- lim,
	send(@boton,free),
	send(@btncarrera,free),
	carreras(Carrer),
	send(@texto,selection('De acuerdo con sus respuestas obtenidas usted tiene el prefil de ingreso de:')),
	send(@resp1,selection(Carrer)),
	new(@boton,button('Iniciar su Test Vocacional Itch',message(@prolog,botones))),
	send(Menu, display,@boton,point(40,50)),
	send(Menu, display,@btncarrera,point(20,50)),
	limpiar.
lim :- send(@resp1, selection('')).





