<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulaire de Paie - BusinessSuite RH</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --navy-blue: #1A365D;
            --navy-light: #2D4A7C;
            --navy-dark: #0F1F3D;
            --cream: #F8F9FA;
            --cream-dark: #E9ECEF;
            --white: #FFFFFF;
            --gray: #6C757D;
            --gray-light: #DEE2E6;
            --gray-lighter: #F8F9FA;
            --accent: #2563EB;
            --success: #198754;
            --warning: #FFC107;
            --danger: #DC3545;
            --info: #0DCAF0;
            --border-radius: 8px;
            --box-shadow: 0 2px 10px rgba(26, 54, 93, 0.08);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Segoe UI', sans-serif;
            line-height: 1.5;
            color: var(--navy-blue);
            background: var(--cream);
            min-height: 100vh;
            padding: 2rem;
        }


        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 2rem;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--gray-light);
        }

        .main-content {
            width: 100%;
        }
        
        .page-title h2 {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--navy-blue);
            margin-bottom: 0.25rem;
        }

        .page-title p {
            color: var(--gray);
            font-size: 0.9rem;
        }

        .user-menu {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .logout-btn, .back-btn {
            background: var(--navy-blue);
            color: var(--white);
            padding: 0.75rem 1.5rem;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.875rem;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .logout-btn:hover, .back-btn:hover {
            background: var(--navy-light);
        }

        .form-container {
            background: var(--white);
            padding: 2rem;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            max-width: 600px;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-size: 0.875rem;
            font-weight: 500;
            color: var(--navy-blue);
            margin-bottom: 0.5rem;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--gray-light);
            border-radius: var(--border-radius);
            font-size: 0.875rem;
            transition: var(--transition);
            background: var(--white);
        }

        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: var(--navy-blue);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2rem;
            padding-top: 1rem;
            border-top: 1px solid var(--gray-light);
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: var(--border-radius);
            font-weight: 500;
            font-size: 0.875rem;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: var(--navy-blue);
            color: var(--white);
        }

        .btn-primary:hover {
            background: var(--navy-light);
        }

        .btn-secondary {
            background: var(--gray-light);
            color: var(--navy-blue);
            text-decoration: none;
        }

        .btn-secondary:hover {
            background: var(--gray);
            color: var(--white);
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .main-content {
                margin-left: 0;
                padding: 1rem;
            }
            
            body {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Sidebar Navigation -->
        <!-- Contenu Principal -->
        <main class="main-content">
            <!-- Top Bar -->
            <div class="top-bar">
                <div class="page-title">
                    <h2>Formulaire de Paiement</h2>
                    <p>Calculer la fiche de paie pour ${employe.prenom} ${employe.nom}</p>
                </div>
                <div class="user-menu">
                    <a href="${pageContext.request.contextPath}/rh/employe" class="back-btn">
                        <i class="fas fa-arrow-left"></i>
                        Retour à la liste
                    </a>
                </div>
            </div>

            <!-- Formulaire -->
            <div class="form-container">
                <form action="${pageContext.request.contextPath}/rh/employe/calculerPaie" method="post">
                    <input type="hidden" name="id_emp" value="${idEmp}">
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="periode_debut">
                                <i class="fas fa-calendar-alt"></i>
                                Période début
                            </label>
                            <input type="date" id="periode_debut" name="periode_debut" value="2025-12-01" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="periode_fin">
                                <i class="fas fa-calendar-alt"></i>
                                Période fin
                            </label>
                            <input type="date" id="periode_fin" name="periode_fin" value="2025-12-31" required>
                        </div>
                    </div>

                    <div class="form-grid">
                        <div class="form-group">
                            <label for="heures_sup_normales">
                                <i class="fas fa-clock"></i>
                                Heures supplémentaires normales
                            </label>
                            <input type="number" id="heures_sup_normales" name="heures_sup_normales" 
                                   step="0.5" value="0" min="0" placeholder="0">
                        </div>
                        
                        <div class="form-group">
                            <label for="heures_sup_weekend">
                                <i class="fas fa-weekend"></i>
                                Heures supplémentaires weekend
                            </label>
                            <input type="number" id="heures_sup_weekend" name="heures_sup_weekend" 
                                   step="0.5" value="0" min="0" placeholder="0">
                        </div>
                    </div>

                    <div class="form-grid">
                        <div class="form-group">
                            <label for="prime_anciennete">
                                <i class="fas fa-award"></i>
                                Prime ancienneté (Ar)
                            </label>
                            <input type="number" id="prime_anciennete" name="prime_anciennete" 
                                   value="0" min="0" placeholder="0">
                        </div>
                        
                        <div class="form-group">
                            <label for="absences">
                                <i class="fas fa-user-clock"></i>
                                Absences (heures)
                            </label>
                            <input type="number" id="absences" name="absences" 
                                   value="0" min="0" placeholder="0">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="autres_primes">
                            <i class="fas fa-gift"></i>
                            Autres primes (Ar)
                        </label>
                        <input type="number" id="autres_primes" name="autres_primes" 
                               value="0" min="0" placeholder="0">
                    </div>

                    <div class="form-group">
                        <label for="mode_paiement">
                            <i class="fas fa-credit-card"></i>
                            Mode de paiement
                        </label>
                        <select id="mode_paiement" name="mode_paiement">
                            <option value="Virement" selected>Virement bancaire</option>
                            <option value="Chèque">Chèque</option>
                            <option value="Espèces">Espèces</option>
                        </select>
                    </div>

                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/rh/employe" class="btn btn-secondary">
                            <i class="fas fa-times"></i>
                            Annuler
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-calculator"></i>
                            Calculer la paie
                        </button>
                    </div>
                </form>
            </div>
        </main>
    </div>
</body>
</html>