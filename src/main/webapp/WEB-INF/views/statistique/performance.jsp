<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Performance RH - BusinessSuite RH</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --primary: #2C3E50;
            --primary-light: #34495E;
            --secondary: #3498DB;
            --accent: #2980B9;
            --success: #27AE60;
            --warning: #F39C12;
            --danger: #E74C3C;
            --light: #ECF0F1;
            --dark: #2C3E50;
            --gray: #95A5A6;
            --gray-light: #BDC3C7;
            --white: #FFFFFF;
            --border-radius: 16px;
            --shadow: 0 12px 40px rgba(0,0,0,0.12);
            --shadow-light: 0 6px 20px rgba(0,0,0,0.08);
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            line-height: 1.6;
            color: var(--dark);
            background: var(--light);
            min-height: 100vh;
        }

        /* Layout Principal */
        .admin-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Navigation */
        .sidebar {
            width: 280px;
            background: var(--primary);
            color: var(--white);
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            transition: var(--transition);
            z-index: 1000;
        }

        .sidebar-header {
            padding: 2rem 1.5rem;
            border-bottom: 1px solid var(--primary-light);
        }

        .sidebar-header h1 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .sidebar-header p {
            font-size: 0.875rem;
            color: var(--gray-light);
            opacity: 0.8;
        }

        .nav-menu {
            padding: 1.5rem 0;
        }

        .nav-item {
            margin-bottom: 0.5rem;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 0.875rem 1.5rem;
            color: var(--white);
            text-decoration: none;
            transition: var(--transition);
            border-left: 3px solid transparent;
        }

        .nav-link:hover, .nav-link.active {
            background: var(--primary-light);
            border-left-color: var(--secondary);
        }

        .nav-link i {
            margin-right: 0.75rem;
            width: 20px;
            text-align: center;
        }

        /* Contenu Principal */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 2rem;
            background: var(--light);
        }

        /* Top Bar */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--gray-light);
        }

        .page-title h2 {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 0.25rem;
        }

        .page-title p {
            color: var(--gray);
            font-size: 0.9rem;
        }

        /* Cartes de Statistiques */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--white);
            padding: 2rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-light);
            transition: var(--transition);
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(135deg, var(--secondary), var(--accent));
        }

        .stat-card.turnover-high::before { background: var(--danger); }
        .stat-card.turnover-medium::before { background: var(--warning); }
        .stat-card.turnover-low::before { background: var(--success); }

        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: var(--secondary);
        }

        .stat-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 1rem;
        }

        .kpi-value {
            font-size: 3rem;
            font-weight: 700;
            line-height: 1;
            margin-bottom: 1rem;
        }

        .kpi-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--light);
        }

        .kpi-detail {
            text-align: center;
        }

        .kpi-detail-value {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--primary);
            display: block;
        }

        .kpi-detail-label {
            font-size: 0.8rem;
            color: var(--gray);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Graphiques et Tableaux */
        .charts-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .chart-card, .table-card {
            background: var(--white);
            padding: 2rem;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow-light);
        }

        .chart-card h5, .table-card h5 {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .chart-card h5 i, .table-card h5 i {
            color: var(--secondary);
        }

        .chart-container {
            position: relative;
            height: 300px;
            width: 100%;
        }

        .table-container {
            max-height: 300px;
            overflow-y: auto;
            border-radius: 8px;
            border: 1px solid var(--light);
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.875rem;
        }

        .data-table th {
            background: var(--light);
            color: var(--primary);
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            border-bottom: 1px solid var(--gray-light);
            position: sticky;
            top: 0;
        }

        .data-table td {
            padding: 1rem;
            border-bottom: 1px solid var(--light);
        }

        .data-table tbody tr:hover {
            background: var(--light);
        }

        .badge {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge-success { background: var(--success); color: var(--white); }
        .badge-warning { background: var(--warning); color: var(--dark); }
        .badge-danger { background: var(--danger); color: var(--white); }

        /* Alertes */
        .alert {
            padding: 1rem 1.5rem;
            border-radius: var(--border-radius);
            margin-bottom: 2rem;
            border-left: 4px solid;
        }

        .alert-danger {
            background: rgba(231, 76, 60, 0.1);
            border-color: var(--danger);
            color: var(--danger);
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .sidebar {
                width: 250px;
            }
            .main-content {
                margin-left: 250px;
            }
        }

        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }
            .sidebar.active {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
            }
            .charts-grid {
                grid-template-columns: 1fr;
            }
            .stats-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }
            .top-bar {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <!-- Sidebar Navigation -->
        <jsp:include page="../sidebar/sidebarRh.jsp" />

        <!-- Contenu Principal -->
        <main class="main-content">
            <!-- Top Bar -->
            <div class="top-bar">
                <div class="page-title">
                    <h2>Indicateurs de Performance RH</h2>
                    <p>Analyse du turnover et de l'absentéisme</p>
                </div>
            </div>

            <!-- Alertes -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-triangle"></i>
                    ${error}
                </div>
            </c:if>

            <!-- KPI Principaux -->
            <div class="stats-grid">
                <!-- Turnover -->
                <div class="stat-card 
                    <c:choose>
                        <c:when test="${turnover.tauxPourcent > 10}">turnover-high</c:when>
                        <c:when test="${turnover.tauxPourcent > 5}">turnover-medium</c:when>
                        <c:otherwise>turnover-low</c:otherwise>
                    </c:choose>">
                    <div class="stat-icon">
                        <i class="fas fa-sync-alt"></i>
                    </div>
                    <div class="stat-title">Taux de Turnover</div>
                    <div class="kpi-value">${turnover.tauxPourcent}%</div>
                    <div class="kpi-details">
                        <div class="kpi-detail">
                            <span class="kpi-detail-value">${turnover.departs}</span>
                            <span class="kpi-detail-label">Départs</span>
                        </div>
                        <div class="kpi-detail">
                            <span class="kpi-detail-value">${turnover.embauchesTotal}</span>
                            <span class="kpi-detail-label">Embauches</span>
                        </div>
                    </div>
                    <small class="text-muted">12 derniers mois</small>
                </div>

                <!-- Absentéisme -->
                <div class="stat-card 
                    <c:choose>
                        <c:when test="${absenteisme.tauxPourcent > 8}">turnover-high</c:when>
                        <c:when test="${absenteisme.tauxPourcent > 4}">turnover-medium</c:when>
                        <c:otherwise>turnover-low</c:otherwise>
                    </c:choose>">
                    <div class="stat-icon">
                        <i class="fas fa-procedures"></i>
                    </div>
                    <div class="stat-title">Taux d'Absentéisme</div>
                    <div class="kpi-value">${absenteisme.tauxPourcent}%</div>
                    <div class="kpi-details">
                        <div class="kpi-detail">
                            <span class="kpi-detail-value">${absenteisme.employesAbsents}</span>
                            <span class="kpi-detail-label">Absents</span>
                        </div>
                        <div class="kpi-detail">
                            <span class="kpi-detail-value">${absenteisme.effectifTotal}</span>
                            <span class="kpi-detail-label">Effectif</span>
                        </div>
                    </div>
                    <small class="text-muted">Mois en cours</small>
                </div>

                <!-- Santé RH -->
                <div class="stat-card 
                    <c:choose>
                        <c:when test="${100 - turnover.tauxPourcent - absenteisme.tauxPourcent > 85}">turnover-low</c:when>
                        <c:when test="${100 - turnover.tauxPourcent - absenteisme.tauxPourcent > 70}">turnover-medium</c:when>
                        <c:otherwise>turnover-high</c:otherwise>
                    </c:choose>">
                    <div class="stat-icon">
                        <i class="fas fa-heartbeat"></i>
                    </div>
                    <div class="stat-title">Santé RH Globale</div>
                    <div class="kpi-value">
                        <c:set var="santeRH" value="${100 - turnover.tauxPourcent - absenteisme.tauxPourcent}"/>
                        ${String.format('%.1f', santeRH)}%
                    </div>
                    <div class="kpi-details">
                        <div class="kpi-detail">
                            <span class="kpi-detail-value">${turnover.tauxPourcent}%</span>
                            <span class="kpi-detail-label">Turnover</span>
                        </div>
                        <div class="kpi-detail">
                            <span class="kpi-detail-value">${absenteisme.tauxPourcent}%</span>
                            <span class="kpi-detail-label">Absentéisme</span>
                        </div>
                    </div>
                    <small class="text-muted">Indice de santé global</small>
                </div>
            </div>

            <!-- Graphiques et Tableaux -->
            <div class="charts-grid">
                <!-- Graphique Turnover -->
                <div class="chart-card">
                    <h5><i class="fas fa-chart-line"></i> Évolution du Turnover</h5>
                    <div class="chart-container">
                        <canvas id="historiqueTurnoverChart"></canvas>
                    </div>
                </div>

                <!-- Détails Absences -->
                <div class="table-card">
                    <h5><i class="fas fa-list-alt"></i> Détails des Absences par Employé</h5>
                    <div class="table-container">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Employé</th>
                                    <th>Département</th>
                                    <th class="text-end">Jours d'absence</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="absence" items="${detailsAbsences}">
                                    <tr>
                                        <td>${absence.prenom} ${absence.nom}</td>
                                        <td>${absence.departement}</td>
                                        <td class="text-end">
                                            <c:choose>
                                                <c:when test="${absence.joursAbsence > 5}">
                                                    <span class="badge badge-danger">${absence.joursAbsence} j</span>
                                                </c:when>
                                                <c:when test="${absence.joursAbsence > 2}">
                                                    <span class="badge badge-warning">${absence.joursAbsence} j</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-success">${absence.joursAbsence} j</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <script>
        // Graphique historique turnover
        const historiqueCtx = document.getElementById('historiqueTurnoverChart').getContext('2d');

        const historiqueData = [
            <c:forEach var="annee" items="${historiqueTurnover}">
            {
                annee: ${annee.annee},                        
                taux: ${annee.tauxPourcent != null ? annee.tauxPourcent : 0},  
                departs: ${annee.departs},                         
                embauches: ${annee.embauchesTotal}               
            },
            </c:forEach>
        ];

        historiqueData.sort((a, b) => a.annee - b.annee);

        const anneeLabels = historiqueData.map(item => item.annee);
        const tauxData = historiqueData.map(item => item.taux);

        console.log('Données historique turnover:', historiqueData);
        console.log('Labels (années):', anneeLabels);
        console.log('Taux (%):', tauxData);

        if (historiqueData.length > 0) {
            new Chart(historiqueCtx, {
                type: 'line',
                data: {
                    labels: anneeLabels,
                    datasets: [{
                        label: 'Taux de Turnover (%)',
                        data: tauxData,
                        borderColor: '#e74a3b',
                        backgroundColor: 'rgba(231, 74, 59, 0.1)',
                        borderWidth: 2,
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: true
                        },
                        tooltip: {
                            callbacks: {
                                afterLabel: function(context) {
                                    const data = historiqueData[context.dataIndex];
                                    return `Départs: ${data.departs} | Embauches: ${data.embauches}`;
                                }
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Taux de Turnover (%)'
                            }
                        },
                        x: {
                            title: {
                                display: true,
                                text: 'Année'
                            }
                        }
                    }
                }
            });
        } else {
            historiqueCtx.font = '16px Arial';
            historiqueCtx.fillStyle = '#666';
            historiqueCtx.textAlign = 'center';
            historiqueCtx.fillText('Aucune donnée historique disponible', 
                historiqueCtx.canvas.width / 2, 
                historiqueCtx.canvas.height / 2
            );
            console.warn('Aucune donnée disponible pour le graphique turnover');
        }

        // Menu responsive
        document.addEventListener('DOMContentLoaded', function() {
            const menuToggle = document.createElement('button');
            menuToggle.innerHTML = '<i class="fas fa-bars"></i>';
            menuToggle.style.cssText = `
                position: fixed;
                top: 1rem;
                left: 1rem;
                background: var(--primary);
                color: white;
                border: none;
                padding: 0.5rem;
                border-radius: var(--border-radius);
                cursor: pointer;
                z-index: 1001;
                display: none;
            `;
            
            document.body.appendChild(menuToggle);
            
            menuToggle.addEventListener('click', function() {
                document.querySelector('.sidebar').classList.toggle('active');
            });

            function handleResize() {
                if (window.innerWidth <= 992) {
                    menuToggle.style.display = 'block';
                } else {
                    menuToggle.style.display = 'none';
                    document.querySelector('.sidebar').classList.remove('active');
                }
            }

            window.addEventListener('resize', handleResize);
            handleResize();
        });
    </script>
</body>
</html>