import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.Date;

public aspect log {

	pointcut logOperaciones() : call( * ejemplo.cajero.modelo.Cuenta..*(..));

	after(): logOperaciones() {
		try {
			SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			System.out.println(formatter.format(new Date()));
			
			System.out.println("Operacion: " + thisJoinPoint.getSignature().getName());
			
			Object cuenta = thisJoinPoint.getTarget();
	    	Field campoNumero = cuenta.getClass().getDeclaredField("numero");
	    	campoNumero.setAccessible(true);			
	    	String numero = (String) campoNumero.get(cuenta);
			System.out.println("Cuenta: " + numero);			
		} catch (Exception e) {
			System.err.println(e);
		}
		
	}

}