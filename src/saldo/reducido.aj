
package saldo;

import java.lang.reflect.Field;

public aspect reducido {
	pointcut saldoReducido() : call( * ejemplo.cajero.modelo.Cuenta.retirar(..));

	void around(): saldoReducido() {

        try {
        	Object cuenta = thisJoinPoint.getTarget();
        	Field campoSaldo = cuenta.getClass().getDeclaredField("saldo");
        	campoSaldo.setAccessible(true);			
        	Long saldo = (Long) campoSaldo.get(cuenta);
        	
        	Long valor = (Long) thisJoinPoint.getArgs()[0];        	
        	
        	if (saldo-valor < 200000) {
        		throw new Exception("No se puede retirar, saldo reducido activado");
			} else {
				proceed();
			}
        	
		} catch (Exception e) {
			System.err.println(e);
		}

	}
}