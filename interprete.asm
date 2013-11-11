
;Esto es para hacer el código más legible, así se evita usar solo números a la hora de llamar un servicio por ejemplo.
sys_exit        equ     1                                                                   
sys_read        equ     3
sys_write       equ     4
sys_open		equ		5
sys_creat		equ 	8
sys_close		equ		6
sys_unlink		equ 	10
stdin           equ     0
stdout          equ     1

;-------------------------------------------------------------------------------------------------------------------------------------------

section .bss	;Datos no inicializados

; Buffer para leer cada entrada que hace el usuario en el prompt
buffLenParametros: 	equ 80
buffParametros: 	resb buffLenParametros


;-------------------------------------------------------------------------------------------------------------------------------------------

;Buffer en el que se meterá el comando ingresado por el usuario
lenBuffComando		equ 9
buffComando			resb lenBuffComando


;-------------------------------------------------------------------------------------------------------------------------------------------

;Buffer que almacenará el nombre del archivo que se desea borrar
lenNombreArchivoBorrar	equ 20
nombreArchivoBorrar		resb lenNombreArchivoBorrar


;-------------------------------------------------------------------------------------------------------------------------------------------

;Buffer que almacenará el nombre del archivo que se desea mostrar
lenNombreArchivoMostrar	equ 20
nombreArchivoMostrar	resb lenNombreArchivoBorrar



;-------------------------------------------------------------------------------------------------------------------------------------------

;Buffer que almacenará el nombre del archivo que se desea renombrar
lenNombreArchivoRenombrar	equ 20
nombreArchivoRenombrar		resb lenNombreArchivoRenombrar

;Buffer que almacenará el nuevo nombre para el archivo a renombrar

lenNuevoNombreRenombrar		equ 20
nuevoNombreRenombrar		resb lenNuevoNombreRenombrar

;-------------------------------------------------------------------------------------------------------------------------------------------

;Buffer que almacenará la posible palabra --forzado, para verificar si es válida.
lenBuffForzado		equ 20
buffForzado			resb lenBuffForzado

;-------------------------------------------------------------------------------------------------------------------------------------------

;Buffer que guarda lo que digite el usuario cuando se le pregunta si esta seguro que desea hacer una acción.
lenBuffEstaSeguro	equ 10
buffEstaSeguro		resb lenBuffEstaSeguro


;-------------------------------------------------------------------------------------------------------------------------------------------

;Buffer que guarda todo el contenido de un archivo
lenBuffArchivo	equ 2000
buffArchivo		resb lenBuffArchivo


;------------------------------------------------------------------------------------------------------------------------------------
	
; Buffer donde se leera lo que el usuario responda en caso de que se llegue a mostrar el mensaje "error3"
lenByte: 		equ 1
buffbyte: 		resb lenByte


;-------------------------------------------------------------------------------------------------------------------------------------------

section .data	;Datos  inicializados

;Mensaje que contiene el prompt
prompt: 	db "dld& "
lenPrompt	equ $-prompt


;-------------------------------------------------------------------------------------------------------------------------------------------

;Indice temporal que servirá para almacenar posiciones.
indiceTemporal 	dd 0


;-------------------------------------------------------------------------------------------------------------------------------------------

;Mensaje que contiene el valor de forzado, actúa como un booleano, 0 no lo pusieron, 1 si lo pusieron.
forzado		db	"0"
lenForzado 	equ $-forzado


;-------------------------------------------------------------------------------------------------------------------------------------------

;Mensaje temporal para la ayuda (FALTA HACER ESE BLOQUE)
ayuda		db 10,"AYUDANDO JEJEJE",10,10
lenAyuda	equ $-ayuda


;-------------------------------------------------------------------------------------------------------------------------------------------

;Mensaje que pregunta si esta seguro que desea borrar el archivo.
deseaBorrar		db 10,"Está seguro que desea borrar el archivo? (s/n) "
lenDeseaBorrar	equ $-deseaBorrar


;-------------------------------------------------------------------------------------------------------------------------------------------

;Mensaje que pregunta si esta seguro que desea renombrar el archivo
deseaRenombrar		db 10,"Está seguro que desea renombrar el archivo? (s/n) "
lenDeseaRenombrar	equ $-deseaRenombrar


;-------------------------------------------------------------------------------------------------------------------------------------------

;Mensaje de error para cuando la persona no puso ni s ni n al responder una pregunta.
errorEstaSeguro		db 10,"Entrada invalida, debe ingresar s o n",10
lenErrorEstaSeguro	equ $-errorEstaSeguro


;-------------------------------------------------------------------------------------------------------------------------------------------

;Mensaje de error para cuando una entrada es inválida
errorEntradaInvalida		db 10,"La entrada es inválida",10,10
lenErrorEntradaInvalida		equ $-errorEntradaInvalida


;-------------------------------------------------------------------------------------------------------------------------------------------

;Mensaje de error para cuando un archivo que se intenta borrar no existe.
archivoBorrarNoExiste 		db 10,"El archivo que desea borrar no existe",10,10
lenArchivoBorrarNoExiste	equ $-archivoBorrarNoExiste


;-------------------------------------------------------------------------------------------------------------------------------------------

;Mensaje de error para cuando un archivo que se intenta mostrar no existe.
archivoMostrarNoExiste 		db 10,"El archivo que desea mostrar no existe",10,10
lenArchivoMostrarNoExiste	equ $-archivoMostrarNoExiste


;-------------------------------------------------------------------------------------------------------------------------------------------

;Mensaje de error para cuando un archivo que se intenta mostrar no existe.
archivoRenombrarNoExiste 		db 10,"El archivo que desea renombrar no existe",10,10
lenArchivoRenombrarNoExiste		equ $-archivoRenombrarNoExiste


;-------------------------------------------------------------------------------------------------------------------------------------------

;Mensaje que dice que se borró con éxito el archivo
borradoConExito 		db 10,"El archivo se borró con éxito",10,10
lenBorradoConExito		equ $-borradoConExito


;-------------------------------------------------------------------------------------------------------------------------------------------

;Mensaje que dice que se renombró un archivo con éxito
renombradoConExito 			db 10,"El archivo fue renombrado",10,10
lenRenombradoConExito		equ $-renombradoConExito


;-------------------------------------------------------------------------------------------------------------------------------------------

;String con opciones sn, sirve para verificar restricciones.
opcionesSINO 	db "sn"


;-------------------------------------------------------------------------------------------------------------------------------------------

;String en el que se meterá el segundo argumento que la persona ingrese, es usado para hacer comparaciones.
segundoArgumento 		db "                         "
lenSegundoArgumento		equ $-segundoArgumento


;-------------------------------------------------------------------------------------------------------------------------------------------

;String en el que se meterá el segundo argumento que la persona ingrese, es usado para hacer comparaciones.
tercerArgumento 		db "                         "
lenTercerArgumento		equ $-tercerArgumento


;-------------------------------------------------------------------------------------------------------------------------------------------

;Strings con numeros para chequear restricciones de forzado
numero1 		db "1"
numero0			db "0"


;-------------------------------------------------------------------------------------------------------------------------------------------

;Variables que tendran los nombres de los comandos en string, esto para chequear las restricciones 
stringAyuda 	db "--ayuda"
lenStringAyuda	equ $-stringAyuda

stringForzado		db "--forzado"
lenStringForzado	equ $-stringForzado

stringMostrar 		db "mostrar"
lenStringMostrar 	equ $-stringMostrar

stringSalir			db "salir"
lenStringSalir		equ $-stringSalir

stringComparar		db "comparar"
lenStringComparar	equ $-stringComparar

stringBorrar		db "borrar"
lenStringBorrar		equ $-stringBorrar

stringRenombrar		db "renombrar"
lenStringRenombrar	equ $-stringRenombrar

stringCopiar		db "copiar"
lenStringCopiar		equ $-stringCopiar

errorComando		db 10,"Comando Invalido",10,10
lenErrorComando		equ $-errorComando


;-------------------------------------------------------------------------------------------------------------------------------------------

; Variable con proposito estético, separar bloques de strings.
enter: db "", 10
lenEnter: equ $-enter


;-------------------------------------------------------------------------------------------------------------------------------------------

;Double que guarda el len de un archivo leído.
lenArchivo	dd 0


;-------------------------------------------------------------------------------------------------------------------------------------------

;Double que almacena el filedescriptor
fileDescriptor1 dd 0

;-------------------------------------------------------------------------------------------------------------------------------------------

section .text 

	global _start

_start: 									;Inicio del programa
	nop 									;Mantiene el debugger feliz
	
inicio:

	call	imprimirPrompt
	
	mov     ecx, buffParametros		
    mov		edx, buffLenParametros			; Lee y deja en buffParametros lo que ingrese el usuario
    call    ReadText
    
    mov		edx, 0
    mov		ecx, buffParametros				
    mov		ebx, buffComando
    
.cicloMeterComando:

	mov		al, byte [ecx + edx]
	cmp		al, byte 20h
	je		compararConBorrar
	cmp		al, byte 10						;Se va metiendo en ebx (buffComando) los bytes de lo que digitó el usuario hasta encontrar un espacio.
	je		compararConBorrar				;Esto sería el comando ya que se supone que es lo primero que ingresa el usuario. Después brinca a comparar
	mov		byte [ebx + edx], al			;con borrar.
	inc		edx
	jmp 	.cicloMeterComando
	

compararConBorrar:
	mov		edx, 0
	mov		ebx, buffComando				;Deja ya listo en ebx, el buffComando.
	
	
.cicloCompararConBorrar:					;Ciclo que va comparando los bytes del buffComando con el string de borrar

	cmp		edx, lenStringBorrar
	je		verificarArgumentosBorrar		;Si llega al final del ciclo, es porque si era borrar, entonces brinca a verificarArgumentosBorrar.
	mov		al, byte[ebx + edx]				
	cmp		al, byte[stringBorrar + edx]
	jne		compararConMostrar				;Si algún byte es diferente, se va a comparar con mostrar.
	inc 	edx
	jmp		.cicloCompararConBorrar

	
compararConMostrar:

	mov		edx, 0
	mov		ebx, buffComando				;Deja ya listo en ebx, el buffComando.
	
	
.cicloCompararConMostrar:					;Ciclo que va comparando los bytes del buffComando con el string de mostrar

	cmp		edx, lenStringMostrar
	je		verificarArgumentosMostrar					
	mov		al, byte[ebx + edx]
	cmp		al, byte[stringMostrar + edx]
	jne		compararConRenombrar
	inc 	edx
	jmp		.cicloCompararConMostrar
	
	
compararConRenombrar:

	mov		edx, 0
	mov		ebx, buffComando
	
.cicloCompararConRenombrar:

	cmp		edx, lenStringRenombrar
	je		codigoBorrar						
	mov		al, byte[ebx + edx]
	cmp		al, byte[stringRenombrar + edx]
	jne		compararConCopiar
	inc 	edx
	jmp		.cicloCompararConRenombrar
	
	
compararConCopiar:

	mov		edx, 0
	mov		ebx, buffComando
	
.cicloCompararConCopiar:

	cmp		edx, lenStringCopiar
	je		codigoBorrar						
	mov		al, byte[ebx + edx]
	cmp		al, byte[stringCopiar + edx]
	jne		compararConComparar
	inc 	edx
	jmp		.cicloCompararConCopiar
	
compararConComparar:
	
	mov		edx, 0
	mov		ebx, buffComando

.cicloCompararConComparar:

	cmp		edx, lenStringComparar
	je		codigoBorrar						
	mov		al, byte[ebx + edx]
	cmp		al, byte[stringComparar + edx]
	jne		compararConSalir
	inc 	edx
	jmp		.cicloCompararConComparar
	
	
compararConSalir:
	
	mov		edx, 0
	mov		ebx, buffComando
	
.cicloCompararConSalir:							;Ciclo que va comparando los bytes del buffComando con el string de salir.

	cmp		edx, lenStringSalir
	je		fin									;Si se llego al final del ciclo, es porque el comando si era salir, brinca a fin y finaliza la ejecucion
	mov		al, byte[ebx + edx]					;del programa.
	cmp		al, byte[stringSalir + edx]
	jne		imprimirErrorComando
	inc 	edx
	jmp		.cicloCompararConSalir
	
	
	
codigoBorrar:

	call 	imprimirPrompt
	call 	imprimirPrompt
	call 	imprimirPrompt
	call 	imprimirPrompt	
	jmp		fin
	
;-------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------
					;El siguiente código se ejecuta cuando el comando ingresado es borrar
;-------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------

verificarArgumentosBorrar:
	mov		edx, lenStringBorrar + 1			;Se mete a edx el índice que ocupamos para el siguiente ciclo, sería en donde va la primera letra del
	mov		esi, 0								;segundo argumento.
	mov		ecx, buffParametros					;Buffer que se recorrerá con edx
    mov		ebx, segundoArgumento				;buffer donde se irán metiendo bytes, se recorre con esi (desde el inicio)
    
    mov		al, [ecx + lenStringBorrar]
    cmp		al, 10								;Si después de borrar hay más letras pegadas, tira error de comando.
    je		imprimirErrorComando
    
.cicloMeterArgumento2Borrar:

	mov		al, byte [ecx + edx]
	cmp		al, byte 20h					
	je		compararAyudaBorrar
	cmp		al, byte 10							;Ciclo que mete lo que haya despues de borrar en segundoArgumento, hasta encontrar un espacio o un enter
	je		compararAyudaBorrar					;posteriormente brinca a compararAyudaBorrar
	mov		byte [ebx + esi], al
	inc		edx
	inc		esi
	jmp 	.cicloMeterArgumento2Borrar

compararAyudaBorrar:
	
	mov		edx, 0
	mov		ebx, segundoArgumento				;En ebx se mete lo que se quiere comparar.
	
	
.cicloCompararAyudaBorrar:

	cmp		edx, lenStringAyuda
	je		desplegarAyudaBorrar			
	mov		al, byte[ebx + edx]					;Ciclo que va comparando byte por byte de segundo argumento con los bytes de stringAyuda
	cmp		al, byte[stringAyuda + edx]			;Si son iguales va a desplegar ayuda. Si son diferentes va a cargarArchivoBorrar2
	jne		cargarArchivoBorrar2
	inc 	edx
	jmp		.cicloCompararAyudaBorrar
	

desplegarAyudaBorrar:
	mov		ecx, ayuda							;Aquí se abriría el archivo de ayuda para borrar  F A L T A
	mov		edx, lenAyuda
	call	DisplayText
	
;Se brinca aquí cuando si se puso --ayuda, debe moverse a la posicion que está despues de --ayuda, para despues empezar a copiar los bytes en nombreArchivoBorrar
cargarArchivoBorrar1:

	mov		edx, lenStringBorrar + lenStringAyuda + 2		;Con un tipo de fórmula, se saca el índice donde se empezarán a copiar bytes a nombreArchivo
	mov		esi, 0											;Indice para ir recorriendo nombreArchivoBorrar.
	mov		ecx, buffParametros
    mov		ebx, nombreArchivoBorrar
    
    mov		al, byte [ecx + edx-1]
    cmp		al, byte 10										;Si después de --ayuda lo que hay es un enter, vuelve al inicio
    je		inicio
    
    
.cicloCargarArchivoBorrar1:

	mov		al, byte [ecx + edx]
	cmp		al, byte 20h
	je		verificarForzadoBorrar1							;Va introduciendo en nombreArchivoBorrar todos los bytes hasta que encuentre un espacio o un
	cmp		al, byte 10										;enter. Después brinca a verificarForzadoBorrar1
	je		verificarForzadoBorrar1
	mov		byte [ebx + esi], al
	inc		esi
	inc		edx
	jmp 	.cicloCargarArchivoBorrar1
	
;Se brinca aquí cuando no se puso --ayuda, el nombre del archivo ya se encuentra guardado en segundoArgumento, por lo que debe pasarse a nombreArchivoBorrar
cargarArchivoBorrar2:

	mov		edx, 0
	mov		esi, 0
	mov		ecx, segundoArgumento							;Se dejan listos en los registros lo que se ocupa para entrar al siguiente ciclo.
    mov		ebx, nombreArchivoBorrar
    
.cicloCargarArchivoBorrar2:

	mov		al, byte [ecx + edx]
	cmp		al, byte 20h
	je		verificarForzadoBorrar2							;Empieza a copiar byte por byte lo que haya en segundo argumento en nombreArchivoBorrar
	mov		byte [ebx + esi], al
	inc		edx
	inc		esi
	jmp 	.cicloCargarArchivoBorrar2
	

;Se brinca aquí cuando si se había ingresado --ayuda como parte de la entrada
verificarForzadoBorrar1:
	mov		edx, lenStringBorrar + lenStringAyuda + 3		;Indice en el que se empezarán a copiar bytes para en buffForzado
	add		edx, esi										;Falta aumentar edx en el largo del nombre del archivo, este se encuentra en esi.
	mov		esi, 0
	mov		ecx, buffParametros
    mov		ebx, buffForzado
    
    mov		al,byte [ecx + edx-1]
    cmp		al, byte 10										;Si lo que está después del nombre de archivo es un enter, se va a ejecutar borrar de una vez
    je		ejecutarBorrar

    
.cicloCargarForzado1:

	mov		al, byte [ecx + edx]
	cmp		al, byte 20h
	je		compararForzado
	cmp		al, byte 10
	je		compararForzado									;Se va metiendo byte por byte lo que esté después del nombre archivo en buffForzado. Brinca
	mov		byte [ebx + esi], al							;a comparar forzado para ver si se ingresó bien esta parte así --forzado.
	inc		esi
	inc		edx
	jmp 	.cicloCargarForzado1


;Se brinca aquí cuando no se ingresó ayuda, lo que cambia es el índice edx, no se debe sumar el len de ayuda.
verificarForzadoBorrar2:
	mov		edx, lenStringBorrar + 2						;Indice en el que se empezarán a copiar bytes para en buffForzado
	add		edx, esi										;Falta aumentar edx en el largo del nombre del archivo, este se encuentra en esi.
	mov		esi, 0
	mov		ecx, buffParametros
    mov		ebx, buffForzado
    
    mov		al,byte [ecx + edx-1]
    cmp		al, byte 10										;Si lo que está después del nombre de archivo es un enter, se va a ejecutar borrar de una vez
    je		ejecutarBorrar

    
.cicloCargarForzado2:

	mov		al, byte [ecx + edx]
	cmp		al, byte 20h
	je		compararForzado
	cmp		al, byte 10										;Se va metiendo byte por byte lo que esté después del nombre archivo en buffForzado. Brinca
	je		compararForzado									;a comparar forzado para ver si se ingresó bien esta parte así --forzado.
	mov		byte [ebx + esi], al
	inc		esi
	inc		edx
	jmp 	.cicloCargarForzado2
	
compararForzado:

	mov		edx, 0
	mov		ebx, buffForzado								;Mueve a ebx el buffer que se quiere comparar con el stringForzado
	
.cicloCompararForzado:

	cmp		edx, lenStringForzado
	je		forzadoBorrarTrue							;Si se llego al final del ciclo, es porque si era --forzado y brinca a forzadoBorrarTrue
	mov		al, byte[ebx + edx]
	cmp		al, byte[stringForzado + edx]
	jne		ejecutarBorrar								;Si algún byte es distinto, se va a ejecutar borrar sin cambiar a true forzado.
	inc 	edx
	jmp		.cicloCompararForzado


forzadoBorrarTrue:
	mov		al, byte [numero1]
	mov		byte [forzado], al							;Pone un "1" en la variable forzado. Esto equivale a un true.

ejecutarBorrar:

	mov		al, byte [forzado]
	cmp		al, byte[numero0]							;Se pregunta si forzado es un 0, si lo es pregunta si desea borrarlo. Si no lo borra sin preguntar
	je		preguntarDeseaBorrar
	jmp		borrarArchivo

preguntarDeseaBorrar:

	mov		ecx, deseaBorrar
	mov		edx, lenDeseaBorrar						;Imprime la pregunta si desea borrar
	call	DisplayText
	
	mov     ecx, buffEstaSeguro			
    mov		edx, lenBuffEstaSeguro					;Lee lo que ingrese el usuario por teclado y lo guarda en buffVolverAJugar
    call    ReadText 				
    
    cmp		eax, 2									;Se compara la cantidad de caracteres ingresado por el usuario con 2, si no es 2 tira error.
    jne		errorDeseaBorrar
    
    mov		ecx, 0								
    mov		dl, byte [buffEstaSeguro + ecx]
    cmp		dl, byte [opcionesSINO + ecx]			;Se compara el primer byte ingresado por el usuario con una s de opcionesSINO, si es igual
    je		borrarArchivo							;brinca a la etiqueta borrarArchivo
    
    inc		ecx
	cmp		dl, byte [opcionesSINO + ecx]			;Se compara el primer byte ingresado por el usuario con una de opcionesSINO, si es igual
	je		inicio									;brinca a la etiqueta errorDeseaBorrar
	jmp		errorDeseaBorrar


borrarArchivo:
	
	mov		eax, nombreArchivoBorrar				;Se mueve a eax la dirección del buffer que contiene el nombre del archivo
	
	mov		ebx, eax 								;Direccion al nombre del archivo
	mov		ecx, 0									;Read only, solo quiere leer
	mov		eax,sys_open  							;Servicio para abrir un archivo
	int		80h		
	

	test	eax, eax 	;Revisar si el abrir el archivo lo hizo correctamente, SI RETORNA NEGATIVO ESTA MAL, el test actualiza las banderas del status
	js		errorNoExisteBorrar ;Si la bandera del signo(lo último fue negativo, es decir no se abrió correctamente, tira error)
	
	mov		ebx, eax								;Cierro el archivo
	call	Cerrar_Archivo
	
	mov		eax, nombreArchivoBorrar				;Se mueve a eax la dirección del buffer que contiene el nombre del archivo
	
	mov		ebx, eax								;Se mueve a ebx el buffer que contiene el nombre del archivo
	call	Borrar_Archivo							;Se llama la subrutina de borrar archivo, que borra el archivo con el nombre puesto en ebx.
	
	mov		ecx, borradoConExito
	mov		edx, lenBorradoConExito					;Imprime un mensaje de que el archivo se borró con éxito
	call	DisplayText
	
	
	call 	ResetearInterprete						;Se resetean variables y registros.
	
	jmp		inicio									;Vuelve al inicio para esperar un nuevo comando.
	


;-------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------
					;El siguiente código se ejecuta cuando el comando ingresado es mostrar.
;-------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------

verificarArgumentosMostrar:
	mov		edx, lenStringMostrar + 1			;Se mete a edx el índice que ocupamos para el siguiente ciclo, sería en donde va la primera letra del
	mov		esi, 0								;segundo argumento.
	mov		ecx, buffParametros					;Buffer que se recorrerá con edx como indice
    mov		ebx, segundoArgumento				;buffer donde se irán metiendo bytes, se recorre con esi (desde el inicio)
    
    mov		al, [ecx + lenStringMostrar]
    cmp		al, 10								;Si después de mostrar hay más letras pegadas, tira error de comando.
    je		imprimirErrorComando
    
.cicloMeterArgumento2Mostrar:

	mov		al, byte [ecx + edx]
	cmp		al, byte 20h					
	je		compararAyudaMostrar
	cmp		al, byte 10							;Ciclo que mete lo que haya despues de borrar en segundoArgumento, hasta encontrar un espacio o un enter
	je		compararAyudaMostrar				;posteriormente brinca a compararAyudaBorrar
	mov		byte [ebx + esi], al
	inc		edx
	inc		esi
	jmp 	.cicloMeterArgumento2Mostrar

compararAyudaMostrar:
	
	mov		edx, 0
	mov		ebx, segundoArgumento				;En ebx se mete lo que se quiere comparar.
	
	
.cicloCompararAyudaMostrar:

	cmp		edx, lenStringAyuda
	je		desplegarAyudaMostrar			
	mov		al, byte[ebx + edx]					;Ciclo que va comparando byte por byte de segundo argumento con los bytes de stringAyuda
	cmp		al, byte[stringAyuda + edx]			;Si son iguales va a desplegar ayuda. Si son diferentes va a cargarArchivoBorrar2
	jne		cargarArchivoMostrar2
	inc 	edx
	jmp		.cicloCompararAyudaMostrar
	

desplegarAyudaMostrar:
	mov		ecx, ayuda							;Aquí se abriría el archivo de ayuda para borrar  F A L T A
	mov		edx, lenAyuda
	call	DisplayText
	
	
;Se brinca aquí cuando si se puso --ayuda, debe moverse a la posicion que está despues de --ayuda, para despues empezar a copiar los bytes en nombreArchivoMostrar
cargarArchivoMostrar1:

	mov		edx, lenStringMostrar + lenStringAyuda + 2		;Con un tipo de fórmula, se saca el índice donde se empezarán a copiar bytes a nombreArchivo
	mov		esi, 0											;Indice para ir recorriendo nombreArchivoMostrar
	mov		ecx, buffParametros
    mov		ebx, nombreArchivoMostrar
   
    mov		al, byte [ecx + edx-1]
    cmp		al, byte 10										;Si después de --ayuda lo que hay es un enter, vuelve al inicio
    je		inicio
       
.cicloCargarArchivoMostrar1:

	mov		al, byte [ecx + edx]
	cmp		al, byte 20h
	je		ejecutarMostrar						;Va introduciendo en nombreArchivoMostrar todos los bytes hasta que encuentre un espacio o un
	cmp		al, byte 10							;enter. Después brinca a ejecutarMostrar
	je		ejecutarMostrar
	mov		byte [ebx + esi], al
	inc		esi
	inc		edx
	jmp 	.cicloCargarArchivoMostrar1
	
;Se brinca aquí cuando no se puso --ayuda, el nombre del archivo ya se encuentra guardado en segundoArgumento, por lo que debe pasarse a nombreArchivoMostrar
cargarArchivoMostrar2:

	mov		edx, 0
	mov		esi, 0
	mov		ecx, segundoArgumento							;Se dejan listos en los registros lo que se ocupa para entrar al siguiente ciclo.
    mov		ebx, nombreArchivoMostrar
    
.cicloCargarArchivoMostrar2:

	mov		al, byte [ecx + edx]
	cmp		al, byte 20h
	je		ejecutarMostrar									;Empieza a copiar byte por byte lo que haya en segundo argumento en nombreArchivoMostrar
	mov		byte [ebx + esi], al
	inc		edx
	inc		esi
	jmp 	.cicloCargarArchivoMostrar2
	
ejecutarMostrar:

	mov		ecx, enter
	mov		edx, lenEnter							;Se imprime un enter para separar líneas.
	call	DisplayText

	mov		eax, nombreArchivoMostrar				;Se mueve a eax la dirección del buffer que contiene el nombre del archivo
	
	mov		ebx, eax 								;Direccion al nombre del archivo
	mov		ecx, 0									;Read only, solo quiere leer
	mov		eax,sys_open  							;Servicio para abrir un archivo
	int		80h		
	

	test	eax, eax 								;Revisar si el abrir el archivo lo hizo correctamente, si retorna negativo está mal.
	js		errorNoExisteMostrar 					;Si la bandera del signo(lo último fue negativo, es decir no se abrió correctamente, tira error)
	
	mov		[fileDescriptor1], eax					;Guardo el el file descriptor
	mov		ebx, eax 								;Muevo del a al b, el archivo (file descriptor, resultado de la funcion anterior)
	mov		ecx, buffArchivo 						;Muevo al ecx el buffer a donde yo voy a mandar a escribir.
	mov		edx, lenBuffArchivo						;Len del bufferArchivo
	mov		eax, sys_read							;Servicio 3, leer, retorna la cantidad de bytes que leí.
					
	int 	80h			

	mov		ecx, buffArchivo
	mov		edx, eax								;Imprimo lo que leí y guardé en buffArchivo
	call	DisplayText
	
	mov		ebx, [fileDescriptor1]					;Cierro el archivo
	call	Cerrar_Archivo
	
	mov		ecx, enter
	mov		edx, lenEnter							;Se imprime un enter para separar líneas.
	call	DisplayText
	
	call 	ResetearInterprete						;Se resetean variables y registros.
	
	jmp		inicio									;Vuelve al inicio para esperar un nuevo comando.
	
	
;-------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------
					;El siguiente código se ejecuta cuando el comando ingresado es renombrar.
;-------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------

verificarArgumentosRenombrar:

	mov		edx, lenStringRenombrar + 1			;Se mete a edx el índice que ocupamos para el siguiente ciclo, sería en donde va la primera letra del
	mov		esi, 0								;segundo argumento.
	mov		ecx, buffParametros					;Buffer que se recorrerá con edx
    mov		ebx, segundoArgumento				;buffer donde se irán metiendo bytes, se recorre con esi (desde el inicio)
    
    mov		al, [ecx + lenStringRenombrar]
    cmp		al, 10								;Si después de renombrar hay más letras pegadas, tira error de comando.
    je		imprimirErrorComando
    
.cicloMeterArgumento2Renombrar:

	mov		al, byte [ecx + edx]
	cmp		al, byte 20h					
	je		compararAyudaRenombrar
	cmp		al, byte 10							;Ciclo que mete lo que haya despues de borrar en segundoArgumento, hasta encontrar un espacio o un enter
	je		compararAyudaRenombrar				;posteriormente brinca a compararAyudaRenombrar
	mov		byte [ebx + esi], al
	inc		edx
	inc		esi
	jmp 	.cicloMeterArgumento2Renombrar

compararAyudaRenombrar:
	
	mov		edx, 0
	mov		ebx, segundoArgumento				;En ebx se mete lo que se quiere comparar.
	
	
.cicloCompararAyudaRenombrar:

	cmp		edx, lenStringAyuda
	je		desplegarAyudaRenombrar			
	mov		al, byte[ebx + edx]					;Ciclo que va comparando byte por byte de segundo argumento con los bytes de stringAyuda
	cmp		al, byte[stringAyuda + edx]			;Si son iguales va a desplegar ayuda. Si son diferentes va a cargarArchivoRenombrar2
	jne		cargarArchivoRenombrar2
	inc 	edx
	jmp		.cicloCompararAyudaRenombrar
	

desplegarAyudaRenombrar:
	mov		ecx, ayuda							;Aquí se abriría el archivo de ayuda para borrar  F A L T A
	mov		edx, lenAyuda
	call	DisplayText
	
;Se brinca aquí cuando si se puso --ayuda, debe moverse a la posicion que está despues de --ayuda, para despues empezar a copiar los bytes en nombreArchivoBorrar
cargarArchivoRenombrar1:

	mov		edx, lenStringRenombrar + lenStringAyuda + 2	;Con un tipo de fórmula, se saca el índice donde se empezarán a copiar bytes a nombreArchivo
	mov		esi, 0											;Indice para ir recorriendo nombreArchivoRenombrar.
	mov		ecx, buffParametros
    mov		ebx, nombreArchivoRenombrar
    
    mov		al, byte [ecx + edx-1]
    cmp		al, byte 10										;Si después de --ayuda lo que hay es un enter, vuelve al inicio
    je		inicio
    
    
.cicloCargarArchivoRenombrar1:

	mov		al, byte [ecx + edx]
	cmp		al, byte 20h
	je		cargarNombreRenombrar1						;Va introduciendo en nombreArchivoBorrar todos los bytes hasta que encuentre un espacio o un
	cmp		al, byte 10										;enter. Después brinca a verificarForzadoBorrar1
	je		cargarNombreRenombrar1
	mov		byte [ebx + esi], al
	inc		esi
	inc		edx
	jmp 	.cicloCargarArchivoRenombrar1
	
;Se brinca aquí cuando no se puso --ayuda, el nombre del archivo ya se encuentra guardado en segundoArgumento, por lo que debe pasarse a nombreArchivoBorrar
cargarArchivoRenombrar2:

	mov		edx, 0
	mov		esi, 0
	mov		ecx, segundoArgumento							;Se dejan listos en los registros lo que se ocupa para entrar al siguiente ciclo.
    mov		ebx, nombreArchivoRenombrar
    
.cicloCargarArchivoRenombrar2:

	mov		al, byte [ecx + edx]
	cmp		al, byte 20h
	je		cargarNombreRenombrar1							;Empieza a copiar byte por byte lo que haya en segundo argumento en nombreArchivoBorrar
	mov		byte [ebx + esi], al
	inc		edx
	inc		esi
	jmp 	.cicloCargarArchivoRenombrar2
	

;Se brinca aquí cuando si se había ingresado --ayuda como parte de la entrada
cargarNombreRenombrar1:

	mov		edx, lenStringRenombrar + lenStringAyuda + 3		;Indice en el que se empezarán a copiar bytes para en buffForzado
	add		edx, esi											;Falta aumentar edx en el largo del nombre del archivo, este se encuentra en esi.
	mov		[indiceTemporal], edx								;Se guarda el indice
	mov		esi, 0
	mov		ecx, buffParametros
    mov		ebx, nuevoNombreRenombrar
    
    mov		al,byte [ecx + edx-1]
    cmp		al, byte 10								;Si lo que está después del nombre de archivo es un enter, se va a ejecutar borrar de una vez
    je		mostrarErrorEntrada

    
.cicloCargarNombreRenombrar1:

	mov		al, byte [ecx + edx]
	cmp		al, byte 20h
	je		verificarForzadoRenombrar
	cmp		al, byte 10
	je		verificarForzadoRenombrar				;Se va metiendo byte por byte lo que esté después del nombre archivo en buffForzado. Brinca
	mov		byte [ebx + esi], al					;a comparar forzado para ver si se ingresó bien esta parte así --forzado.
	inc		esi
	inc		edx
	jmp 	.cicloCargarNombreRenombrar1


;Se brinca aquí cuando no se ingresó ayuda, lo que cambia es el índice edx, no se debe sumar el len de ayuda.
cargarNombreRenombrar2:
	mov		edx, lenStringRenombrar + 2				;Indice en el que se empezarán a copiar bytes para en buffForzado
	add		edx, esi								;Falta aumentar edx en el largo del nombre del archivo, este se encuentra en esi.
	mov		[indiceTemporal], edx					;Se guarda el indice
	mov		esi, 0
	mov		ecx, buffParametros
    mov		ebx, nuevoNombreRenombrar
    
    mov		al,byte [ecx + edx-1]
    cmp		al, byte 10								;Si lo que está después del nombre de archivo es un enter, se va a ejecutar borrar de una vez
    je		mostrarErrorEntrada

    
.cicloCargarNombreRenombrar2:

	mov		al, byte [ecx + edx]
	cmp		al, byte 20h
	je		verificarForzadoRenombrar
	cmp		al, byte 10								;Se va metiendo byte por byte lo que esté después del nombre archivo en buffForzado. Brinca
	je		verificarForzadoRenombrar				;a comparar forzado para ver si se ingresó bien esta parte así --forzado.
	mov		byte [ebx + esi], al
	inc		esi
	inc		edx
	jmp 	.cicloCargarNombreRenombrar2
	
verificarForzadoRenombrar:
	mov		edx, [indiceTemporal]					;Indice en el que se empezarán a copiar bytes para en buffForzado
	add		edx, esi								;Falta aumentar edx en el largo del nombre del archivo a renombrar, este se encuentra en esi.
	inc		edx										;Por ultimo se le aumenta 1 para queya quede apuntando a la primera letra del posible --forzado
	mov		esi, 0
	mov		ecx, buffParametros
    mov		ebx, buffForzado
    
    mov		al,byte [ecx + edx-1]
    cmp		al, byte 10								;Si lo que está después del nombre de archivo es un enter, se va a ejecutar borrar de una vez
    je		ejecutarRenombrar

    
.cicloCargarForzadoRenombrar:

	mov		al, byte [ecx + edx]
	cmp		al, byte 20h
	je		compararForzadoRenombrar
	cmp		al, byte 10
	je		compararForzadoRenombrar				;Se va metiendo byte por byte lo que esté después del nombre archivo en buffForzado. Brinca
	mov		byte [ebx + esi], al					;a comparar forzado para ver si se ingresó bien esta parte así --forzado.
	inc		esi
	inc		edx
	jmp 	.cicloCargarForzadoRenombrar


compararForzadoRenombrar:

	mov		edx, 0
	mov		ebx, buffForzado						;Mueve a ebx el buffer que se quiere comparar con el stringForzado
	
.cicloCompararForzadoRenombrar:

	cmp		edx, lenStringForzado
	je		forzadoRenombrarTrue					;Si se llego al final del ciclo, es porque si era --forzado y brinca a forzadoBorrarTrue
	mov		al, byte[ebx + edx]
	cmp		al, byte[stringForzado + edx]
	jne		ejecutarRenombrar						;Si algún byte es distinto, se va a ejecutar borrar sin cambiar a true forzado.
	inc 	edx
	jmp		.cicloCompararForzadoRenombrar


forzadoRenombrarTrue:
	mov		al, byte [numero1]
	mov		byte [forzado], al						;Pone un "1" en la variable forzado. Esto equivale a un true.

ejecutarRenombrar:

	mov		al, byte [forzado]
	cmp		al, byte[numero0]						;Se pregunta si forzado es un 0, si lo es pregunta si desea borrarlo. Si no lo borra sin preguntar
	je		preguntarDeseaRenombrar
	jmp		renombrarArchivo

preguntarDeseaRenombrar:

	mov		ecx, deseaRenombrar
	mov		edx, lenDeseaRenombrar					;Imprime la pregunta si desea borrar
	call	DisplayText
	
	mov     ecx, buffEstaSeguro			
    mov		edx, lenBuffEstaSeguro					;Lee lo que ingrese el usuario por teclado y lo guarda en buffVolverAJugar
    call    ReadText 				
    
    cmp		eax, 2									;Se compara la cantidad de caracteres ingresado por el usuario con 2, si no es 2 tira error.
    jne		errorDeseaRenombrar
    
    mov		ecx, 0								
    mov		dl, byte [buffEstaSeguro + ecx]
    cmp		dl, byte [opcionesSINO + ecx]			;Se compara el primer byte ingresado por el usuario con una s de opcionesSINO, si es igual
    je		renombrarArchivo						;brinca a la etiqueta borrarArchivo
    
    inc		ecx
	cmp		dl, byte [opcionesSINO + ecx]			;Se compara el primer byte ingresado por el usuario con una de opcionesSINO, si es igual
	je		inicio									;brinca a la etiqueta errorDeseaBorrar
	jmp		errorDeseaRenombrar
	
renombrarArchivo:
	
	mov		eax, nombreArchivoRenombrar				;Se mueve a eax la dirección del buffer que contiene el nombre del archivo
	
	mov		ebx, eax 								;Direccion al nombre del archivo
	mov		ecx, 0									;Read only, solo quiere leer
	mov		eax,sys_open  							;Servicio para abrir un archivo
	int		80h		
	

	test	eax, eax 	;Revisar si el abrir el archivo lo hizo correctamente, SI RETORNA NEGATIVO ESTA MAL, el test actualiza las banderas del status
	js		errorNoExisteRenombrar ;Si la bandera del signo(lo último fue negativo, es decir no se abrió correctamente, tira error)
	
	mov		[fileDescriptor1], eax					;Guardo el el file descriptor
	mov		ebx, eax 								;Muevo del a al b, el archivo (file descriptor, resultado de la funcion anterior)
	mov		ecx, buffArchivo 						;Muevo al ecx el buffer a donde yo voy a mandar a escribir.
	mov		edx, lenBuffArchivo						;Len del bufferArchivo
	mov		eax, sys_read							;Servicio 3, leer, retorna la cantidad de bytes que leí.
					
	int 	80h
	
	mov		[lenArchivo], eax						;Guardo en lenArchivo la cantidad de bytes que se leyeron.
	
	mov		eax, nombreArchivoRenombrar				;Se mueve a eax la dirección del buffer que contiene el nombre del archivo
	
	mov		ebx, eax								;Se mueve a ebx el buffer que contiene el nombre del archivo
	call	Borrar_Archivo							;Se llama la subrutina de borrar archivo, que borra el archivo con el nombre puesto en ebx.
	
	mov		eax, nuevoNombreRenombrar			
	mov 	ebx, eax			    				; Guardamos en "ebx" el nombre que tendrá el archivo que se quiere crear.
	
	; Se crea el archivo
	mov 	ecx, 511 				    			; Modo de acceso
	call 	Crear_Archivo 
	
	mov		eax, nuevoNombreRenombrar
	
	mov		ebx, eax 								;Direccion al nombre del archivo
	mov		ecx, 1									;Modo de acceso para poder escribir.
	mov		eax,sys_open  							;Servicio para abrir un archivo
	int		80h	
	
	mov 	[fileDescriptor1], eax 					; Se guarda el fd del archivo
	mov		esi, 0
	
	
	
	mov		esi, buffArchivo			;esi apunta al buffer del archivo
	mov 	edi, 0						;índice que irá recorriendo todo el archivo

	mov		dl , byte [esi + edi]
	
.cicloLlenarArchivo:

	mov		byte [buffbyte], dl
	mov		ecx, buffbyte				;Escribe en el archivo el byte correspondiente.
	mov		edx, lenByte
	call	Escribir_Archivo
	inc 	edi
	mov		dl , byte [esi + edi]
	mov		eax, [lenArchivo]			;Se guarda el largo del archivo para saber cuando dejar de copiar caracteres
	cmp 	edi, eax					;Si el índice ya llegó al largo del tablero, deja de copiar y termina la subrutina
	je 		cerrarArchivoRenombrado
	jmp 	.cicloLlenarArchivo

cerrarArchivoRenombrado:
	mov		ebx, [fileDescriptor1]
	call 	Cerrar_Archivo
	
	mov		ecx, renombradoConExito
	mov 	edx, lenRenombradoConExito
	call	DisplayText
	
	call 	ResetearInterprete						;Se resetean variables y registros.
	
	jmp		inicio									;Vuelve al inicio para esperar un nuevo comando.
	


;-------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------
					;El siguiente código se ejecuta cuando el comando ingresado es copiar.
;-------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------------------

errorNoExisteBorrar:
	mov		ecx, archivoBorrarNoExiste
	mov		edx, lenArchivoBorrarNoExiste		;Muestra error de que el archivo que se intenta borrar no existe
	call	DisplayText
	
	call	ResetearInterprete					;Resetea el interprete
	jmp		inicio								;Vuelve al prompt.
	
errorNoExisteMostrar:
	mov		ecx, archivoMostrarNoExiste
	mov		edx, lenArchivoMostrarNoExiste		;Muestra error de que el archivo que se intenta borrar no existe
	call	DisplayText
	
	call	ResetearInterprete					;Resetea el interprete
	jmp		inicio								;Vuelve al prompt.

errorNoExisteRenombrar:
	mov		ecx, archivoRenombrarNoExiste
	mov		edx, lenArchivoRenombrarNoExiste	;Muestra error de que el archivo que se intenta renombrar no existe
	call	DisplayText
	
	call	ResetearInterprete					;Resetea el interprete
	jmp		inicio								;Vuelve al prompt.

errorDeseaBorrar:
	mov		ecx, errorEstaSeguro
	mov		edx, lenErrorEstaSeguro				;Muestra el error de que la entradaa no fue válida para cuando se pregunta si desea borrar el archivo.
	call	DisplayText
	
	jmp		preguntarDeseaBorrar
	
errorDeseaRenombrar:
	mov		ecx, errorEstaSeguro
	mov		edx, lenErrorEstaSeguro				;Muestra el error de que la entradaa no fue válida para cuando se pregunta si desea renombrar el archivo.
	call	DisplayText
	
	jmp		preguntarDeseaRenombrar

mostrarErrorEntrada:
	mov		ecx, errorEntradaInvalida
	mov		edx, lenErrorEntradaInvalida		;Muestra un error en la entrada
	call	DisplayText
	
	call	ResetearInterprete
	jmp		inicio
	
	
	
	
	
	
imprimirErrorComando:

	mov 	ecx, errorComando
	mov 	edx, lenErrorComando
	call 	DisplayText
	jmp		inicio
	

fin:  							;Finaliza la ejecucion del programa.
								
	mov 	eax, 1
	mov 	ebx, 0
	int 	80h






;Subrutina que resetea variables del juego
ResetearInterprete:
	xor 	eax,eax
	xor 	ebx, ebx				;Se limpian los registros
	xor 	ecx, ecx
	xor 	edx, edx
	
	mov		al, byte[numero0]		;Se vuelve a poner en 0 forzado.
	mov		byte[forzado], al
	
	ret
	
;Muestra en el monitor lo que tenga en el registro ecx, con el largo en edx.

DisplayText:

    mov     eax, sys_write
    mov     ebx, stdout
    int     80H 
    ret 
    
;Subrutina encargada de imprimir el prompt, ya que despues de ejecutar un comando se debe volver a imprimir.

imprimirPrompt:

	mov		ecx, prompt
	mov		edx, lenPrompt
	call	DisplayText
    
;Para borrar un archivo

Borrar_Archivo:

	mov 	eax, sys_unlink 
	int 	80h
	ret


;-----------------------------------------------------------------------------------------------------------------------------------------------------	

Crear_Archivo: ; Subrutina para crear archivos
	
	mov 	eax, sys_creat
	int 	80h
	ret
	

;-----------------------------------------------------------------------------------------------------------------------------------------------------	
	
Abrir_Archivo: ; Subrutina para abrir archivos 

	mov 	eax, sys_open
	int 	80h
	ret


;-----------------------------------------------------------------------------------------------------------------------------------------------------	

Escribir_Archivo: ; Subrutina para escribir en un archivo
	
	mov 	eax, sys_write  
	int 	80h
	ret


;-----------------------------------------------------------------------------------------------------------------------------------------------------	

Cerrar_Archivo: ; Subrutina para cerrar un archivo
	
	mov 	eax, sys_close
	int 	80h
	ret


;-----------------------------------------------------------------------------------------------------------------------------------------------------	

Leer_Archivo: ; Subrutina para leer un archivo

	mov 	eax, 3
	int 	80h
	ret
	
;-----------------------------------------------------------------------------------------------------------------------------------------------------
 
; Lee algo de la entrada estándar debe "setearse" lo siguiente:
; ecx: el puntero al buffer donde se almacenará
; edx: el largo del mensaje a leer

ReadText:

    mov     ebx, stdin
    mov     eax, sys_read
    int     80H
    ret

