<dashboard>
  <label>AEM Content</label>
  <description>Publisher and Dispatcher Activations</description>
  <row>
    <panel>
      <title>Publisher Activations (24h)</title>
      <table>
        <search>
          <query>PUBHOSTLIST source="CRXDIR/logs/access.log" "POST /bin/receive?sling:authRequestLogin=1" | stats count by host</query>
          <earliest>-24h@h</earliest>
          <latest>now</latest>
        </search>
        <option name="count">10</option>
        <option name="drilldown">none</option>
      </table>
    </panel>
  </row>
  <row>
    <panel>
      <title>Dispatcher Invalidations (24h)</title>
      <table>
        <search>
          <query>WEBHOSTLIST source="HTLOGS/dispatcher.log" "GET /dispatcher/invalidate.cache" | stats count by host</query>
          <earliest>-24h@h</earliest>
          <latest>now</latest>
        </search>
        <option name="count">10</option>
        <option name="drilldown">none</option>
      </table>
    </panel>
  </row>
</dashboard>