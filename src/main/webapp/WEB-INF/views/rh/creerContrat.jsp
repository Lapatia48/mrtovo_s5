<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Créer Contrat - BusinessSuite</title>
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
            --warning: #ffc107;
            --danger: #dc3545;
            --border-radius: 8px;
            --box-shadow: 0 2px 15px rgba(26, 54, 93, 0.1);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Segoe UI', sans-serif;
            line-height: 1.6;
            color: var(--navy-blue);
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            min-height: 100vh;
        }

        .main-content {
            max-width: 1000px;
            margin: 0 auto;
            padding: 2rem;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding: 1.5rem;
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
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

        .back-btn, .logout-btn {
            background: var(--navy-blue);
            color: var(--white);
            padding: 0.75rem 1.5rem;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.875rem;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 2px 5px rgba(26, 54, 93, 0.2);
        }

        .back-btn:hover, .logout-btn:hover {
            background: var(--navy-light);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(26, 54, 93, 0.3);
        }

        /* Messages d'alerte */
        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1rem;
            border-left: 4px solid var(--danger);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .success-message {
            background: #d4edda;
            color: #155724;
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1rem;
            border-left: 4px solid var(--success);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Carte d'information employé */
        .info-card {
            background: var(--white);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            margin-bottom: 2rem;
            border-left: 4px solid var(--accent);
            box-shadow: var(--box-shadow);
        }

        .info-card h3 {
            color: var(--navy-blue);
            margin-bottom: 1rem;
            font-size: 1.25rem;
            font-weight: 600;
        }

        .info-card p {
            color: var(--gray);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .info-card strong {
            color: var(--navy-blue);
            min-width: 140px;
            display: inline-block;
        }

        /* Formulaire */
        .form-container {
            background: var(--white);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 2rem;
        }

        .form-section {
            margin-bottom: 2rem;
            padding: 1.5rem;
            background: var(--gray-lighter);
            border-radius: var(--border-radius);
            border-left: 4px solid var(--navy-blue);
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--navy-blue);
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid var(--gray-light);
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-label {
            font-size: 0.875rem;
            color: var(--gray);
            margin-bottom: 0.5rem;
            font-weight: 500;
        }

        .form-input, .form-select {
            padding: 0.75rem;
            border: 1px solid var(--gray-light);
            border-radius: var(--border-radius);
            font-size: 0.875rem;
            transition: var(--transition);
            background: var(--white);
        }

        .form-input:focus, .form-select:focus {
            outline: none;
            border-color: var(--navy-blue);
            box-shadow: 0 0 0 2px rgba(26, 54, 93, 0.1);
            transform: translateY(-1px);
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 2rem;
            padding-top: 1.5rem;
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
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .btn-primary {
            background: var(--navy-blue);
            color: var(--white);
        }

        .btn-primary:hover {
            background: var(--navy-light);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(26, 54, 93, 0.3);
        }

        .btn-secondary {
            background: var(--gray-light);
            color: var(--navy-blue);
        }

        .btn-secondary:hover {
            background: var(--gray);
            color: var(--white);
            transform: translateY(-2px);
        }

        /* Indicateurs de champ requis */
        .required::after {
            content: " *";
            color: var(--danger);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }
            
            .top-bar {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }
            
            .user-menu {
                flex-direction: column;
                width: 100%;
            }
            
            .back-btn, .logout-btn {
                width: 100%;
                justify-content: center;
            }
            
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 576px) {
            .top-bar {
                padding: 1rem;
            }
            
            .page-title h2 {
                font-size: 1.5rem;
            }
            
            .form-container {
                padding: 1.5rem;
            }
            
            .form-section {
                padding: 1rem;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <!-- Contenu Principal -->
    <main class="main-content">
        <!-- Top Bar -->
        <div class="top-bar">
            <div class="page-title">
                <h2>Créer un Contrat</h2>
                <p>Nouveau contrat pour ${employe.prenom} ${employe.nom}</p>
            </div>
            <div class="user-menu">
                <a href="${pageContext.request.contextPath}/rh/employe" class="back-btn">
                    <i class="fas fa-arrow-left"></i>
                    Retour aux employés
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                    <i class="fas fa-sign-out-alt"></i>
                    Déconnexion
                </a>
            </div>
        </div>

        <!-- Messages d'alerte -->
        <c:if test="${not empty error}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <!-- Info Employé -->
        <div class="info-card">
            <h3>Informations de l'Employé</h3>
            <p><strong>Nom complet:</strong> ${employe.prenom} ${employe.nom}</p>
            <p><strong>Poste:</strong> ${employe.poste}</p>
            <p><strong>Département:</strong> ${employe.departement}</p>
            <p><strong>Salaire actuel:</strong> ${employe.salaire} Ar</p>
        </div>

        <!-- Formulaire de création de contrat -->
        <form action="${pageContext.request.contextPath}/rh/contrat/save" method="post" class="form-container">
            <input type="hidden" name="idEmploye" value="${employe.id}">
            
            <!-- Section Informations Contrat -->
            <div class="form-section">
                <h3 class="section-title">Informations du Contrat</h3>
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label required">Type de contrat</label>
                        <select name="typeContrat" class="form-select" required>
                            <option value="">Sélectionnez...</option>
                            <c:forEach var="type" items="${typesContrat}">
                                <option value="${type}">${type}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label required">Numéro de contrat</label>
                        <input type="text" name="numeroContrat" class="form-input" 
                               placeholder="CTR-2025-001" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label required">Date de début</label>
                        <input type="date" name="dateDebut" class="form-input" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Date de fin</label>
                        <input type="date" name="dateFin" class="form-input" 
                               placeholder="CDI = laisser vide">
                    </div>
                </div>
            </div>

            <!-- Section Poste et Rémunération -->
            <div class="form-section">
                <h3 class="section-title">Poste et Rémunération</h3>
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label required">Poste</label>
                        <input type="text" name="poste" class="form-input" 
                               value="${employe.poste}" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Classification</label>
                        <select name="classification" class="form-select">
                            <option value="">Sélectionnez...</option>
                            <c:forEach var="classif" items="${classifications}">
                                <option value="${classif}">${classif}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label required">Salaire de base</label>
                        <input type="number" name="salaireBase" class="form-input" 
                               value="${employe.salaire}" step="0.01" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Durée hebdomadaire</label>
                        <input type="number" name="dureeHebdomadaire" class="form-input" 
                               value="35" min="1" max="60">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Temps de travail</label>
                        <select name="tempsTravail" class="form-select">
                            <c:forEach var="temps" items="${tempsTravail}">
                                <option value="${temps}">${temps}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Section Période d'Essai -->
            <div class="form-section">
                <h3 class="section-title">Période d'Essai</h3>
                <div class="form-grid">
                    <div class="form-group">
                        <label class="form-label">Durée (jours)</label>
                        <input type="number" name="periodeEssaiJours" class="form-input" 
                               value="0" min="0" max="180">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Date de fin d'essai</label>
                        <input type="date" name="dateFinEssai" class="form-input">
                    </div>
                </div>
            </div>

            <!-- Actions -->
            <div class="form-actions">
                <a href="${pageContext.request.contextPath}/rh/employe" class="btn btn-secondary">
                    <i class="fas fa-times"></i>
                    Annuler
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i>
                    Créer le Contrat
                </button>
            </div>
        </form>
    </main>

    <script>
        // Calcul automatique de la date de fin d'essai
        document.querySelector('input[name="periodeEssaiJours"]').addEventListener('input', function() {
            const joursEssai = parseInt(this.value);
            const dateDebutInput = document.querySelector('input[name="dateDebut"]');
            
            if (joursEssai > 0 && dateDebutInput.value) {
                const dateDebut = new Date(dateDebutInput.value);
                const dateFinEssai = new Date(dateDebut);
                dateFinEssai.setDate(dateDebut.getDate() + joursEssai);
                
                document.querySelector('input[name="dateFinEssai"]').value = dateFinEssai.toISOString().split('T')[0];
            } else if (joursEssai === 0) {
                document.querySelector('input[name="dateFinEssai"]').value = '';
            }
        });

        // Gestion CDI/CDD
        document.querySelector('select[name="typeContrat"]').addEventListener('change', function() {
            const dateFinInput = document.querySelector('input[name="dateFin"]');
            if (this.value === 'CDI') {
                dateFinInput.value = '';
                dateFinInput.placeholder = 'CDI = pas de date de fin';
            } else {
                dateFinInput.placeholder = 'Date de fin requise';
            }
        });

        // Validation de la date de fin pour les CDD
        document.querySelector('form').addEventListener('submit', function(e) {
            const typeContrat = document.querySelector('select[name="typeContrat"]').value;
            const dateFin = document.querySelector('input[name="dateFin"]').value;
            
            if (typeContrat === 'CDD' && !dateFin) {
                e.preventDefault();
                alert('Pour un CDD, la date de fin est obligatoire.');
                document.querySelector('input[name="dateFin"]').focus();
            }
        });
    </script>
</body>
</html>