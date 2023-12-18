--Author: Federico Cianci
--Data: 18/12/2023
--Overview: Query che seleziona tutti gli attributi principali dei libri incluse le letture (completamenti) dell'autore
--          comprensive di data di inizio lettura, data di fine lettura e di un campo generato che calcola il numero
--          di giorni impiegati a leggere un libro della base di dati.
SELECT l.IDLibro,l.Titolo,l.ISBN13,a.NomeAutore,a.CognomeAutore,a.NazionalitàAutore,l.AnnoPubblicazione,
c.NomeCasaEditrice,e.NumeroEdizione,e.AnnoEdizione,li.LinguaLibro,li.LinguaOriginale,t.NomeTraduttore,
t.CognomeTraduttore,cm.DataInizioLettura,cm.DataFineLettura,l.NumPagine,cm.PagineLette,
(julianday(cm.DataFineLettura) - julianday(cm.DataInizioLettura)) AS GiorniCompletamento 
FROM Libri l
JOIN AutoriELibri al ON al.IDLibro = l.IDLibro
JOIN Autori a ON a.IDAutore = al.IDAutore
JOIN Edizioni e ON e.IDLibro = l.IDLibro
JOIN CaseEditrici c ON c.IDCasaEditrice = e.IDCasaEditrice
JOIN LingueTesto lt ON lt.IDLibro = l.IDLibro
JOIN Lingue li ON lt.IDLingua = li.IDLingua
JOIN Traduzioni tr ON tr.IDLibro = l.IDLibro
JOIN Traduttori t ON tr.IDTraduttore = t.IDTraduttore
JOIN CompletamentiLibri cml ON cml.IDLibro = l.IDLibro
JOIN Completamenti cm ON cm.IDCompletamento = cml.IDCompletamento
ORDER BY l.Titolo ASC;