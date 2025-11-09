<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<form action="${pageContext.request.contextPath}/rh/employe/calculerPaie" method="post">
    <input type="hidden" name="id_emp" value="${idEmp}">
    
    <label>Période début:</label>
    <input type="date" name="periode_debut" required>
    
    <label>Période fin:</label>
    <input type="date" name="periode_fin" required>
    
    <label>Heures supplémentaires normales:</label>
    <input type="number" name="heures_sup_normales" step="0.5" value="0">
    
    <label>Heures supplémentaires weekend:</label>
    <input type="number" name="heures_sup_weekend" step="0.5" value="0">
    
    <label>Prime ancienneté:</label>
    <input type="number" name="prime_anciennete" value="0">
    
    <label>Absences (en heures):</label>
    <input type="number" name="absences" value="0">
    
    <label>Autres primes:</label>
    <input type="number" name="autres_primes" value="0">
    
    <label>Mode de paiement:</label>
    <select name="mode_paiement">
        <option value="Virement">Virement</option>
        <option value="Chèque">Chèque</option>
    </select>
    
    <button type="submit">Calculer</button>
</form>