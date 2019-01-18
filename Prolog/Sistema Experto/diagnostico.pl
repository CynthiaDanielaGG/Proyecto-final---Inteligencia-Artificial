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

	send(Menu, append(L)),new(@btncarrera,button('�Desea iniciar?')),
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
	pregunta('�Te gusta el dise�o de edificios'),
	pregunta('�Te gustaria tener clases de campo(fuera del aula)'),
	pregunta('�Eres habil para las matematicas?'),
	pregunta('�Te gusta la construccion de edificios?'),
	pregunta('�Te gustar�a trabajar en obras sanitarias?'),
	pregunta('�Eres habil para la fisica?'),
	pregunta('�Te gustaria trabajar en obras civiles?').
sistemas :- es_sistemas,
	pregunta('�Te gusta el desarrollo de aplicaciones?'),
	pregunta('�Tienes la habilidad para analizar un problema?'),
	pregunta('�Eres habil para las matematicas?'),
	pregunta('�Te gustaria trabajar en un laboratorio de computo?'),
	pregunta('�Te gustaria administrar bases de datos?'),
	pregunta('�Te gustaria conocer sobre las redes de computadoras?'),
	pregunta('�Tienes habilidades para lo circuitos electronicos?').
informatica :- es_informatica,
	pregunta('�Te gustaria administrar sistemas informaticos?'),
	pregunta('�Realizar auditorias en centros de computo?'),
	pregunta('�Tienes habilidad por las matematicas?'),
	pregunta('�Te gustaria conocer mas sobre la administracion de sistemas operativos?'),
	pregunta('�Te gustaria conocer sobre la administracion de archivos?'),
	pregunta('�Te gustaria administrar redes de comunicacion?'),
	pregunta('�Tienes habilidad para dar mantenimiento preventivo y correctivo a las computadoras?').
gestion :- es_gestion,
	pregunta('�Te gustaria establecer programas para el fortalecimiento de la
	seguridad e higiene en las organizaciones?'),
	pregunta('�Te gustaria realizar estrategias para la mejora de una empresa?'),
	pregunta('�Tienes habilidades basicas para matematicas?'),
	pregunta('�Te gustaria Aplicar m�todos cuantitativos y cualitativos para
	el an�lisis e interpretaci�n de datos
	y modelado de sistemas, en los procesos organizacionales para la mejora
	continua, atendiendo est�ndares de calidad
	mundial?'),
	pregunta('�Te gustaria utilizar las nuevas tecnolog�as de informaci�n en
	la organizaci�n, para optimizar los procesos
	de comunicaci�n y eficientar la toma de decisiones?'),
	pregunta('�Te gustaria interpretar y aplicar normas legales que incidan en
	la creaci�n y desarrollo de las organizaciones?'),
	pregunta('�Te gustaria gestionar sistemas integrales de calidad, ejerciendo
	un liderazgo efectivo y un compromiso
	�tico, aplicando las herramientas b�sicas de la ingenier�a?').
contador :- es_contador,
	pregunta('�Te gustaria dise�ar, implantar, controlar, evaluar, asesorar e
	innovar sistemas de informaci�n financiera,
	administrativa, fiscal y de auditor�a en entidades econ�micas?'),
	pregunta('�Te gustaria analizar y generar informaci�n financiera con apego
	a las Normas de Informaci�n Financiera,
	nacionales e internacionales, para la toma de decisiones?'),
	pregunta('�Te gustaria auditar sistemas financieros, fiscales y administrativos
	de las entidades econ�micas con apego
	a las Normas y Procedimientos de Auditoria y Normas para Atestiguar?'),
	pregunta('�Te gustaria aplicar el marco legal pertinente a las caracter�sticas
	y necesidades de la entidad econ�mica
	dentro del campo profesional?'),
	pregunta('�Te gustaria administrar estrat�gicamente los recursos de las entidades
	econ�micas con visi�n emprendedora y
	competitiva?'),
	pregunta('�Te gustaria utilizar las Tecnolog�as de Informaci�n y Comunicaci�n
	para eficientar los procesos y la toma de
	decisiones.?'),
	pregunta('�Te gustaria aplicar m�todos de an�lisis de informaci�n financiera
	para determinar las mejores alternativas de
	inversi�n y financiamiento ?').

%%desconocido :- no_exite_carrera.

es_civil :- pregunta('�Tienes habilidad por el dise�o de obras civiles?'),!.
es_sistemas :- pregunta('�Tienes habilidades por el desarrollo de software?'),!.
es_informatica :- pregunta('�Tienes habilidades para el hadware de computadoras?'),!.
es_gestion :- pregunta('�Tienes habilidades de lider?'),!.
es_contador :- pregunta('�Tienes habilidades para gestionar recursos financieros'),!.

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





