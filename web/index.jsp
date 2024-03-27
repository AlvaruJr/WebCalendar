<% 
    String anoParam = request.getParameter("ano");
    String mesParam = request.getParameter("mes");
    String diaParam = request.getParameter("dia");
    boolean dadosValidos = true;

    if (anoParam != null && mesParam != null && diaParam != null) {
        try {
            int ano = Integer.parseInt(anoParam);
            int mes = Integer.parseInt(mesParam) - 1;
            int dia = Integer.parseInt(diaParam);

            java.util.Calendar calendario = java.util.Calendar.getInstance();
            calendario.setLenient(false);
            calendario.set(ano, mes, dia);

            int diasNoMes = calendario.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);

            calendario.set(java.util.Calendar.DAY_OF_MONTH, 1);
            int primeiroDiaDaSemana = calendario.get(java.util.Calendar.DAY_OF_WEEK);

            StringBuilder calendarioHtml = new StringBuilder();
            calendarioHtml.append("<table>");
            calendarioHtml.append("<tr><th>Dom</th><th>Seg</th><th>Ter</th><th>Qua</th><th>Qui</th><th>Sex</th><th>S�b</th></tr>");

            int contador = 1;
            calendarioHtml.append("<tr>");

            for (int i = 1; i < primeiroDiaDaSemana; i++) {
                calendarioHtml.append("<td></td>");
                contador++;
            }

            for (int i = 1; i <= diasNoMes; i++) {
                String estilo = (i == dia) ? "color: red;" : "";
                calendarioHtml.append("<td style=\"" + estilo + "\">").append(i).append("</td>");
                contador++;
                if (contador % 7 == 1) {
                    calendarioHtml.append("</tr><tr>");
                }
            }

            while (contador % 7 != 1) {
                calendarioHtml.append("<td></td>");
                contador++;
            }

            calendarioHtml.append("</tr>");
            calendarioHtml.append("</table>");

            out.println(calendarioHtml.toString());
        } catch (NumberFormatException e) {
            out.println("<p>Por favor, forne�a um n�mero v�lido para o ano, m�s e dia.</p>");
            dadosValidos = false;
        } catch (IllegalArgumentException e) {
            out.println("<p>A data fornecida � inv�lida. Por favor, forne�a uma data v�lida.</p>");
            dadosValidos = false;
        }
    } else {
        dadosValidos = false;
    }

    if (!dadosValidos) {
%>
    <h2>Por favor, forne�a os par�metros corretos:</h2>
    <form action="" method="get">
        <label for="ano">Ano:</label>
        <input type="text" id="ano" name="ano" required><br><br>
        
        <label for="mes">M�s:</label>
        <input type="text" id="mes" name="mes" required><br><br>
        
        <label for="dia">Dia:</label>
        <input type="text" id="dia" name="dia" required><br><br>
        
        <input type="submit" value="Mostrar Calend�rio">
    </form>
<%
    }
%>
